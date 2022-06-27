Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936A55D285
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbiF0P4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiF0P4t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 11:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7331AE;
        Mon, 27 Jun 2022 08:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 437666162F;
        Mon, 27 Jun 2022 15:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EADAC3411D;
        Mon, 27 Jun 2022 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656345407;
        bh=0uKIHk5NAfqiC1sw9PWOYGqU8fOKFZ6Vg6CrIR19Zgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZHHtIFw51nNpjsX7K/dxIQcTbD2G+uJd1OfO3hGMoQGBgPQxqvCUqglpOJ+0Miq1
         /K9FJ6bviXkg8wvG9kV6dx2lv8AS20+9aO0WKX6mGy4sWw4nEM0sKNiC1vw1oXz0S8
         MZC45o3icMlBflLrxfR5pKEh6xshNAP+BJb5XnUEKnHgz3Eq1HkDflYfMJKH94Uv9/
         pInFmw9bADF7m9RkzBOUbRJioaLOLLZd5TIE004Mec+oRIdJki75A6bh0/lDJXQQ5a
         H6/cA13NJWiimkA6z33xsWtpyYowiwfMSH4XGy7/ueH8+uOhaRdVFplx04Sh009dWU
         0kV3+gimxBa0w==
Date:   Mon, 27 Jun 2022 17:56:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 0/2] Introduce security_create_user_ns()
Message-ID: <20220627155639.b5jky27loen3ydrz@wittgenstein>
References: <20220621233939.993579-1-fred@cloudflare.com>
 <ce1653b1-feb0-1a99-0e97-8dfb289eeb79@schaufler-ca.com>
 <b72c889a-4a50-3330-baae-3bbf065e7187@cloudflare.com>
 <CAHC9VhSTkEMT90Tk+=iTyp3npWEm+3imrkFVX2qb=XsOPp9F=A@mail.gmail.com>
 <20220627121137.cnmctlxxtcgzwrws@wittgenstein>
 <b7c23d54-d196-98d1-8187-605f6d4dca4d@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7c23d54-d196-98d1-8187-605f6d4dca4d@cloudflare.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 27, 2022 at 10:51:48AM -0500, Frederick Lawler wrote:
> On 6/27/22 7:11 AM, Christian Brauner wrote:
> > On Thu, Jun 23, 2022 at 11:21:37PM -0400, Paul Moore wrote:
> > > On Wed, Jun 22, 2022 at 10:24 AM Frederick Lawler <fred@cloudflare.com> wrote:
> > > > On 6/21/22 7:19 PM, Casey Schaufler wrote:
> > > > > On 6/21/2022 4:39 PM, Frederick Lawler wrote:
> > > > > > While creating a LSM BPF MAC policy to block user namespace creation, we
> > > > > > used the LSM cred_prepare hook because that is the closest hook to
> > > > > > prevent
> > > > > > a call to create_user_ns().
> > > > > > 
> > > > > > The calls look something like this:
> > > > > > 
> > > > > >       cred = prepare_creds()
> > > > > >           security_prepare_creds()
> > > > > >               call_int_hook(cred_prepare, ...
> > > > > >       if (cred)
> > > > > >           create_user_ns(cred)
> > > > > > 
> > > > > > We noticed that error codes were not propagated from this hook and
> > > > > > introduced a patch [1] to propagate those errors.
> > > > > > 
> > > > > > The discussion notes that security_prepare_creds()
> > > > > > is not appropriate for MAC policies, and instead the hook is
> > > > > > meant for LSM authors to prepare credentials for mutation. [2]
> > > > > > 
> > > > > > Ultimately, we concluded that a better course of action is to introduce
> > > > > > a new security hook for LSM authors. [3]
> > > > > > 
> > > > > > This patch set first introduces a new security_create_user_ns() function
> > > > > > and create_user_ns LSM hook, then marks the hook as sleepable in BPF.
> > > > > 
> > > > > Why restrict this hook to user namespaces? It seems that an LSM that
> > > > > chooses to preform controls on user namespaces may want to do so for
> > > > > network namespaces as well.
> > > > 
> > > > IIRC, CLONE_NEWUSER is the only namespace flag that does not require
> > > > CAP_SYS_ADMIN. There is a security use case to prevent this namespace
> > > > from being created within an unprivileged environment. I'm not opposed
> > > > to a more generic hook, but I don't currently have a use case to block
> > > > any others. We can also say the same is true for the other namespaces:
> > > > add this generic security function to these too.
> > > > 
> > > > I'm curious what others think about this too.
> > > 
> > > While user namespaces are obviously one of the more significant
> > > namespaces from a security perspective, I do think it seems reasonable
> > > that the LSMs could benefit from additional namespace creation hooks.
> > > However, I don't think we need to do all of them at once, starting
> > > with a userns hook seems okay to me.
> > > 
> > > I also think that using the same LSM hook as an access control point
> > > for all of the different namespaces would be a mistake.  At the very
> > 
> > Agreed. >
> > > least we would need to pass a flag or some form of context to the hook
> > > to indicate which new namespace(s) are being requested and I fear that
> > > is a problem waiting to happen.  That isn't to say someone couldn't
> > > mistakenly call the security_create_user_ns(...) from the mount
> > > namespace code, but I suspect that is much easier to identify as wrong
> > > than the equivalent security_create_ns(USER, ...).
> > 
> > Yeah, I think that's a pretty unlikely scenario.
> > 
> > > 
> > > We also should acknowledge that while in most cases the current task's
> > > credentials are probably sufficient to make any LSM access control
> > > decisions around namespace creation, it's possible that for some
> > > namespaces we would need to pass additional, namespace specific info
> > > to the LSM.  With a shared LSM hook this could become rather awkward.
> > 
> > Agreed.
> > 
> > > 
> > > > > Also, the hook seems backwards. You should
> > > > > decide if the creation of the namespace is allowed before you create it.
> > > > > Passing the new namespace to a function that checks to see creating a
> > > > > namespace is allowed doesn't make a lot off sense.
> > > > 
> > > > I think having more context to a security hook is a good thing.
> > > 
> > > This is one of the reasons why I usually like to see at least one LSM
> > > implementation to go along with every new/modified hook.  The
> > > implementation forces you to think about what information is necessary
> > > to perform a basic access control decision; sometimes it isn't always
> > > obvious until you have to write the access control :)
> > 
> > I spoke to Frederick at length during LSS and as I've been given to
> > understand there's a eBPF program that would immediately use this new
> > hook. Now I don't want to get into the whole "Is the eBPF LSM hook
> > infrastructure an LSM" but I think we can let this count as a legitimate
> > first user of this hook/code.
> > 
> > > 
> > > [aside: If you would like to explore the SELinux implementation let me
> > > know, I'm happy to work with you on this.  I suspect Casey and the
> > > other LSM maintainers would also be willing to do the same for their
> > > LSMs.]
> > > 
> 
> I can take a shot at making a SELinux implementation, but the question
> becomes: is that for v2 or a later patch? I don't think the implementation
> for SELinux would be too complicated (i.e. make a call to avc_has_perm()?)
> but, testing and revisions might take a bit longer.
> 
> > > In this particular case I think the calling task's credentials are
> > > generally all that is needed.  You mention that the newly created
> > 
> > Agreed.
> > 
> > > namespace would be helpful, so I'll ask: what info in the new ns do
> > > you believe would be helpful in making an access decision about its
> > > creation?
> > > 
> 
> In the other thread [1], there was mention of xattr mapping support. As I
> understand Caseys response to this thread [2], that feature is no longer
> requested for this hook.

I think that is an orthogonal problem at least wrt to this hook.

> 
> Users can still access the older parent ns from the passed in cred, but I
> was thinking of handling the transition point here. There's probably more
> suitable hooks for that case.

Yes.
