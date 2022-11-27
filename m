Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB75639BAA
	for <lists+bpf@lfdr.de>; Sun, 27 Nov 2022 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiK0QPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 11:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0QPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 11:15:37 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9CB63B8;
        Sun, 27 Nov 2022 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n5m9TdhS9W2Ahe7LJqsvvjnZ4x8/D63jAOgfmSmnpco=; b=ZuI2nfG7NIqdVnL7/igP9qj3cP
        mdbItmAXyhGNnkeRsv4T2I7ww71lYLriXqEV5rRi0jg57AcSrH0619DGK/M1Lxmeo8iGT43A2NAH/
        8l9Jpo3KuU8OnkarUC7xrBKnervzGxNk1Q1jw3jMNlDZYWU4UlwWCEHwni7p3MgD2ip4+fN0Ax+Tz
        eWupSk/s8c/y25V3wfPoyMIsDOV8UhEvmh87CBk/dkUozYIUhsxTXObPyMxxAU9hSCA+kfOQOxCSP
        wFpTApd16QsBEEDL+jRtciXLnltprGHB0N2fj4L4ExNjdV8yIRAS3g97e4UomcOdVLU154398jB9X
        8Wtu2+uw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ozKJU-0079wc-2A;
        Sun, 27 Nov 2022 16:15:28 +0000
Date:   Sun, 27 Nov 2022 16:15:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y4ONIFJatIGsVNpf@ZenIV>
References: <20221016163855.8173-1-fmdefrancesco@gmail.com>
 <Y4E++JERgUMoqfjG@ZenIV>
 <Y4FG0O7VWTTng5yh@ZenIV>
 <2188828.irdbgypaU6@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2188828.irdbgypaU6@suse>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 26, 2022 at 03:12:16PM +0100, Fabio M. De Francesco wrote:

> Al, thanks for taking the time to answer in such detail although I can believe 
> that, to spot the mistakes in my patch and then write your email, it probably 
> took you 10 minutes or so :-)

FWIW, it's generally useful to ask yourself if patch can be made less noisy -
are there any regular parts that could be carved out of it, how much is due to
calling conventions changes and can those be done differently, etc.

If it can be decomposed into simpler parts, it becomes easier to review (and
that includes debugging - when bisect points to a commit and you need to find
what's wrong with it, splitting that change into several steps is often
a useful approach; if nothing else, you get a chance to bisect that and
narrow the area to look into, but often enough you'll spot the bug while
carving the change up).

Below is what I'd actually done when reviewing that thing (and it took more
than 10 minutes):

What happens in this patch?
	1) switch from kmap/kunmap to kmap_local_page/kunmap_local; that's
in ufs_get_page() and ufs_put_page().  OK, so ufs_put_page() needs to be
supplied with the virtual address in addition to page.  And callers of
ufs_get_page() need the virtual address to access, not just the page.

	2) pages fed to ufs_put_page() ultimately come from earlier
ufs_get_page(), so presumably virtual address could be propagated along
the same path.  OK...

	3) change in ufs_inode_by_name() seems to fit the above -
ufs_find_entry() used to return page, now it returns page and address;
that address is fed to ufs_put_page().
	So what has ufs_find_entry() become?  2 "in" arguments (directory
inode and entry name), 2 "out" arguments (page and virtual address of the
first byte in that page) and return value - pointer to directory entry.
So basically we are passing directory and name and get a triple -
	* pointer to directory entry
	* page reference that need to be held so we could access that
directory entry
	* pointer to the first byte of the page that contains directory
entry...
	Looks redundant - the 3rd component is simply the 1st one rounded
down to page size...

	And it seems that at least some of the affected functions are
in the same situation - they are already working in terms of <pointer to
directory entry, pointer to page> pairs, and with those adding the
virtual address is redundant.  Let's see...

	4) functions with changed calling conventions are
		ufs_put_page()
		ufs_set_link()
		ufs_check_page()
		ufs_get_page()
		ufs_dotdot()
		ufs_find_entry()
		ufs_delete_entry()
	Out of those, ufs_put_page() and ufs_get_page() are consumer and
producer of the virtual address, and ufs_check_page() needs the address
as well, but other four all seem to be in the same boat -
pair <pointer to directory entry, page> becomes a triple
<pointer to directory entry, page, pointer to the first byte of page>
and that's redundant.
	ufs_set_link() and ufs_delete_entry() have that triple passed
to them; ufs_find_entry() and ufs_dotdot() return such triple to the
caller.
	Looks like we could replace e.g.
	de = ufs_dotdot(inode, &page, &addr);
	if (de) {
		...
		ufs_put_page(page, addr);
	}
with
	de = ufs_dotdot(inode, &page);
	if (de) {
		addr = <round de down>
		...
		ufs_put_page(page, addr);
	}
	That would return the call to what it used to be; whether it's a win
or not, depends upon the things we use addr for.  Let's check...

	5) ufs_set_link(inode, de, page, addr, ...) always gets de, page and
addr coming from the same ufs_find_entry() or ufs_dotdot() call.  I.e.
in all cases addr is rounded-down de; could as well find that value inside
ufs_set_link(), returning the callers to original state.

	6) ufs_delete_entry(dir, de, page, addr) - same story; de, page and
addr come from the same call of ufs_find_entry(), so we can reconstruct
addr by de inside ufs_delete_entry(); no need to pass it down, returning
those callers to original state.

	7) ufs_find_entry() - 4 callers, address is passed to ufs_put_page(),
ufs_delete_entry(), ufs_set_link().  The last two don't really need that
argument, so we are left with "need to round down for passing to ufs_put_page()".

	8) ufs_dotdot() - address is passed to ufs_put_page() or ufs_set_link().
The latter doesn't need that argument, so we are again left with "need to round
down for passing to ufs_put_page()".

	9) So ufs_put_page() gets rounded-down pointer to directory entry here...
Might be worth a helper that would take a page + address and do ufs_put_page()
for page and rounded down address...  But do we even need that to be separate
from ufs_put_page()?  After all, the addresses we are currently passing to
ufs_put_page() are page-aligned, so rounding any of them down to page size
is a no-op.  Might as well change ufs_put_page() from "takes page reference
and virtual address of beginning of the page" to "takes page reference and
virtual address anywhere within the page"; if nothing else, it would reduce
the clutter in fs/ufs/namei.c parts and it might be useful in fs/ufs/dir.c
part as well.  OK, the intermediate plan:
	* ufs_put_page() rounds the address down to page size
	* ufs_set_link() and ufs_delete_entry() do not get page_addr passed
to them; reconstruct it as rounded-down directory entry pointer.  Calling
conventions are back to original.
	* ufs_find_entry() and ufs_dotdot() do not bother returning page_addr.
Calling conventions are back to original.
	* callers of ufs_put_page() in fs/ufs/namei.c give it directory entry
instead of page_addr.  Same for ufs_inode_by_name(), that got us started in
that direction.

	10) ufs_set_link() uses page_addr for two things - finding location
in file (page_offset() + difference between de and page_addr) and feeding it
to ufs_put_page().  The latter can be given de, as we do in other places;
the former would become "difference between de and de rounded down to page
size"... wait a sec - that's just the address modulo page size, aka.
offset_in_page(de).  OK, we don't even need to reconstruct page_addr in
there.  Win...

	11) for ufs_get_page() we want the virtual address returned.  Looking
through the callers, though, shows that calling conventions are clumsy -
we have page = ufs_get_page(dir, n, &page_addr) followed by casting
page_addr to various pointer types, assigning it to various pointer
variables or, in one case, even ufs_get_page(dir, n, (void **)&char_pointer_var)
Ouch...  We have 2 "in" arguments (directory and page number) and
2 values to return to caller - page reference and pointer to beginning of
the page.  The type of the first component is always the same (struct page *),
but the second... depending upon the caller, it may be void *, char *
or struct ufs_dir_entry *.  Passing it out via "out" argument is painful -
return value is much more suitable for that; there we can return void *
and have the assignment in callers convert it as needed.  Page reference,
OTOH, is well-suited for passing out via "out" argument - same type in
all cases.
	So it looks like we want addr = ufs_get_page(dir, n, &page);
as calling conventions.  Callers need to check IS_ERR(addr) instead of
IS_ERR(page), but that's about it.  *AND* they might be able to cut
down on assignments - just store the return value directly in variable
they would copy it into.

	12) ufs_dotdot() needs not bother with returning page_address.
With new calling conventions for ufs_get_page() it doesn't need
'page' or 'page_addr' at all - we want the value of
	ufs_get_page(dir, 0, p)
but we only want it converted to struct ufs_dir_entry *.  And we already
have a variable of just that type declared right there, so we can do
simply
	struct ufs_dir_entry *de = ufs_get_page(dir, 0, p);
The rest becomes
	if (!IS_ERR(de)) {
		de = ufs_next_entry(dir->i_sb, de);
	} else {
		de = NULL;
	}
	return de;
or, better yet, 
	if (!IS_ERR(de))
		return ufs_next_entry(dir->i_sb, de);
	else
		return NULL;
Makes sense - ".." is the second entry in directory, so we ask for the
first page, treat its beginning as entry pointer and return the next
entry...  And yes, it looks like ufs_get_page() callers are happier
with such calling conventions.

	13) ufs_find_entry() - getting rid of res_page_addr argument
is obvious, so's adjusting the calling conventions for ufs_get_page().
Surprisingly subtle question is whether we can get rid of 'page_addr'
there; now that we don't store it in *res_page_addr the only thing
we use it for is ufs_put_page().  With ufs_get_page() calling
conventions change we'd get
	page_addr = ufs_get_page(dir, n, &page);
	if (!IS_ERR(page_addr)) {
		kaddr = page_addr;
		de = (struct ufs_dir_entry *) kaddr;
		kaddr += ufs_last_byte(dir, n) - reclen;
		while ((char *) de <= kaddr) {
		       if (ufs_match(sb, namelen, name, de))
				goto found;
			de = ufs_next_entry(sb, de);
		}
		ufs_put_page(page, page_addr);
	}
We have a couple of other pointers around - kaddr and de.  kaddr is
set to page_addr + something, then de iterates through the entries
starting at page_addr until it gets past kaddr, looking for the match.
So we get to the end of loop if we have *not* found a match within
this page, and de is not guaranteed to point within the same page when
we leave the loop.  Not suitable for passing to ufs_put_page(), then.
kaddr, OTOH, would better be pointing into the same page - we use
de <= kaddr as permission to dereference de, and we'd better not run
out of page.  A look at ufs_last_byte() shows that its return value
is always no greater than PAGE_SIZE, so kaddr is guaranteed to point
within the same page.  Good.  So we can turn that into
	kaddr = ufs_get_page(dir, n, &page);
	if (!IS_ERR(kaddr)) {
		de = (struct ufs_dir_entry *) kaddr;
		kaddr += ufs_last_byte(dir, n) - reclen;
		....
		ufs_put_page(page, kaddr);
	}
and page_addr bites the dust.	

	14) ufs_add_link() - similar adjustment to new calling conventions
for ufs_get_page().  Uses of page_addr: fed to ufs_put_page() (same as
in ufs_find_entry() kaddr is guaranteed to point into the same page and
thus can be used instead) and calculation of position in directory, same
as we'd seen in ufs_set_link().  The latter becomes page_offset(page) +
offset_in_page(de), killing page_addr off.  BTW, we get
		kaddr = ufs_get_page(dir, n, &page);
		err = PTR_ERR(kaddr);
		if (IS_ERR(kaddr))
			goto out;
with out: being just 'return err;', which suggests
		kaddr = ufs_get_page(dir, n, &page);
		if (IS_ERR(kaddr))
			return ERR_PTR(kaddr);
instead (and that was the only goto out; so the label can be removed).
The value stored in err in case !IS_ERR(kaddr) is (thankfully) never
used - would've been a bug otherwise.  So this is an equivalent transformation.

	15) ufs_readdir() - trivial modifications to deal with ufs_get_page()
calling conventions change; an ugly cast goes away.

	16) ufs_delete_entry() - kaddr argument is dropped, we make it a local
variable initialized with rounded down dir.  Incidentally, 'dir - kaddr' can
be replaced with offset_in_page(dir) in there and similar for (char *)pde - kaddr.

	17) ufs_empty_dir() - we adjust to ufs_get_page() calling conventions
change, page_addr can be dropped same as in ufs_find_entry().  Need to lift
kaddr out of loop to deal with not_empty: part (hadn't noticed when writing
original reply, but compiler would've caught that)

	18) fs/ufs/namei.c parts do shrink down to pretty much just 'pass
the right directory entry to ufs_put_page()' (and most of ufs.h changes
disapper).  ufs_get_page() calling conventions change is actually the bulk
of what remains of this patch after that massage.  Other than that we have
several 'use offset_in_page()' local changes and extra argument of
ufs_put_page().  Hmm...  offset_in_page() actually counts as a valid (and
trivially safe) optimization, independent of anything kmap-related.
Worth carving out as the first step in series.  Come to think of that,
ufs_get_page() calling conventions change *also* can be done without
the kmap_local_page() switchover; we would do kmap() and return page_address(page).
Callers would be happier with such calling conventions, and carving that
part out would reduce the patch to just the 'switch ufs_get_page() to
kmap_local_page(), switch ufs_put_page() to kunmap_local() and supply it
with a pointer into the page in question'.  Which is much smaller and
easier to review.
