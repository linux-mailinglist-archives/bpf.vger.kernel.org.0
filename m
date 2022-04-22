Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFF50AF2F
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 06:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiDVEed (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiDVEeb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 00:34:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E74C78C;
        Thu, 21 Apr 2022 21:31:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d15so8241213pll.10;
        Thu, 21 Apr 2022 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=aiWVqABu3voKTHZ4+w18aRluFcBYyu1qvKLlj6PvJis=;
        b=kSGpplEFuO8wgaxMNmQJgmpXLyAr7kl+acxFY1AeFOm8D6Ij3LpcMnHsWbEYblJpbg
         aGrDkao0EJ/g+ZRh0JYlOZR2NW6d7ml7M19LBRKjLe/Rjiz9ofDbTr4EnU+zD6oveE8X
         pBwrWB25CMHKuLGUpzdh4O6IPApuOfWQ/q5zCf8aWJAgK3/v6J9czVQkPeBG5dWpM36m
         9IC7pk9VQzcKB5Dzfu9YJN8WirWCEYH8xBnq6JbZBxeKmiEDj8BVr1pdWCpW3elYNsid
         qq6/WC7vvYhqDGJnr5GpqKNKgMjJSa56L+g8K4Qv58Wpf+1b7M9ddK0NcLncXc5xyC7P
         qwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=aiWVqABu3voKTHZ4+w18aRluFcBYyu1qvKLlj6PvJis=;
        b=hl5KydrDpFD3AleVmL5HEltC8rkKyBei7rZf40/+rNwqMeQuhkVqbx35ps5225U97O
         Vf82yAvgcgW40THAMByYMEbfGRz05iLpgGAgmffN/pud02iO879eFsiRWrvYlGsQowIt
         1j6+ERRZmzw/ijxWPH+Vu7cvvp0u42yxkb6GvSdVuvLt3T2A8USiK6Kf2z6mSmssaSsS
         bxdcA4SjpJhSO4G+IqLPUOreS6MHCk0Ky5LDxJlnxUn5XkR4fU3IhVUQayXvsIh+pziC
         bws+auZpOFczbKimzT+fpq3xAbKwU7JfSlJNs5dbDwDJEqds4mZkeXppAgoGFpVi3Htk
         PkvQ==
X-Gm-Message-State: AOAM5334JLgQCgW0V9+Jo2Ay+aA3q8TcPGjlukWRjdlm1ILh7yS5r/yc
        YMkY8F8LvCteBe6rb1SMOac=
X-Google-Smtp-Source: ABdhPJzdLXI9YcJ9EaK/gWL4RP5q7HkH/jWUuM7o5U1NJbyXAEVxigcksSiFyn6Utl51EYqDhWcxTw==
X-Received: by 2002:a17:902:7d83:b0:158:c7e9:1ff3 with SMTP id a3-20020a1709027d8300b00158c7e91ff3mr2768900plm.55.1650601899042;
        Thu, 21 Apr 2022 21:31:39 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a0d4100b001cd4989fedasm4488950pju.38.2022.04.21.21.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 21:31:38 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:31:33 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
        <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
        <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
        <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
        <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
        <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
        <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
        <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
        <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
        <1650511496.iys9nxdueb.astroid@bobo.none>
        <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
        <1650530694.evuxjgtju7.astroid@bobo.none>
        <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
        <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
        <1650584815.0dtcbd4qky.astroid@bobo.none>
        <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
        <1650596505.bxrmjmgjur.astroid@bobo.none>
In-Reply-To: <1650596505.bxrmjmgjur.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1650601109.vb3owbt14k.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Excerpts from Nicholas Piggin's message of April 22, 2022 1:08 pm:
> Excerpts from Edgecombe, Rick P's message of April 22, 2022 12:29 pm:
>> On Fri, 2022-04-22 at 10:12 +1000, Nicholas Piggin wrote:
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index e163372d3967..70933f4ed069 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -2925,12 +2925,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>                         if (nr !=3D nr_pages_request)
>>>                                 break;
>>>                 }
>>> -       } else
>>> -               /*
>>> -                * Compound pages required for remap_vmalloc_page if
>>> -                * high-order pages.
>>> -                */
>>> -               gfp |=3D __GFP_COMP;
>>> +       }
>>> =20
>>>         /* High-order pages or fallback path if "bulk" fails. */
>>> =20
>>> @@ -2944,6 +2939,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>>                         page =3D alloc_pages_node(nid, gfp, order);
>>>                 if (unlikely(!page))
>>>                         break;
>>> +               /*
>>> +                * Higher order allocations must be able to be
>>> treated as
>>> +                * indepdenent small pages by callers (as they can
>>> with
>>> +                * small page allocs).
>>> +                */
>>> +               if (order)
>>> +                       split_page(page, order);
>>> =20
>>>                 /*
>>>                  * Careful, we allocate and map page-order pages, but
>>=20
>> FWIW, I like this direction. I think it needs to free them differently
>> though? Since currently assumes they are high order pages in that path.
>=20
> Yeah I got a bit excited there, but fairly sure that's the bug.
> I'll do a proper patch.

So here's the patch on top of the revert. Only tested on a lowly
powerpc machine, but it does fix this simple test case that does
what the drm driver is obviously doing:

  size_t sz =3D PMD_SIZE;
  void *mem =3D vmalloc(sz);
  struct page *p =3D vmalloc_to_page(mem + PAGE_SIZE*3);
  p->mapping =3D NULL;
  p->index =3D 0;
  INIT_LIST_HEAD(&p->lru);
  vfree(mem);

Without the below fix the same exact problem reproduces:

  BUG: Bad page state in process swapper/0  pfn:00743
  page:(____ptrval____) refcount:0 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x743
  flags: 0x7ffff000000000(node=3D0|zone=3D0|lastcpupid=3D0x7ffff)
  raw: 007ffff000000000 c00c00000001d0c8 c00c00000001d0c8 0000000000000000
  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: corrupted mapping in tail page
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc3-00082-gfc6fff4a7ce1-=
dirty #2810
  Call Trace:
  [c000000002383940] [c0000000006ebb00] dump_stack_lvl+0x74/0xa8 (unreliabl=
e)
  [c000000002383980] [c0000000003dabdc] bad_page+0x12c/0x170=20
  [c000000002383a00] [c0000000003dad08] free_tail_pages_check+0xe8/0x190
  [c000000002383a30] [c0000000003dc45c] free_pcp_prepare+0x31c/0x4e0
  [c000000002383a90] [c0000000003df9f0] free_unref_page+0x40/0x1b0
  [c000000002383ad0] [c0000000003d7fc8] __vunmap+0x1d8/0x420=20
  [c000000002383b70] [c00000000102e0d8] proc_vmalloc_init+0xdc/0x108
  [c000000002383bf0] [c000000000011f80] do_one_initcall+0x60/0x2c0
  [c000000002383cc0] [c000000001001658] kernel_init_freeable+0x32c/0x3cc
  [c000000002383da0] [c000000000012564] kernel_init+0x34/0x1a0
  [c000000002383e10] [c00000000000ce64] ret_from_kernel_thread+0x5c/0x64

Any other concerns with the fix?

Thanks,
Nick

--
mm/vmalloc: huge vmalloc backing pages should be split rather than compound

Huge vmalloc higher-order backing pages were allocated with __GFP_COMP
in order to allow the sub-pages to be refcounted by callers such as
"remap_vmalloc_page [sic]" (remap_vmalloc_range).

However a similar problem exists for other struct page fields callers
use, for example fb_deferred_io_fault() takes a vmalloc'ed page and
not only refcounts it but uses ->lru, ->mapping, ->index. This is not
compatible with compound sub-pages.

The correct approach is to use split high-order pages for the huge
vmalloc backing. These allow callers to treat them in exactly the same
way as individually-allocated order-0 pages.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 0b17498a34f1..09470361dc03 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2653,15 +2653,18 @@ static void __vunmap(const void *addr, int dealloca=
te_pages)
 	vm_remove_mappings(area, deallocate_pages);
=20
 	if (deallocate_pages) {
-		unsigned int page_order =3D vm_area_page_order(area);
-		int i, step =3D 1U << page_order;
+		int i;
=20
-		for (i =3D 0; i < area->nr_pages; i +=3D step) {
+		for (i =3D 0; i < area->nr_pages; i++) {
 			struct page *page =3D area->pages[i];
=20
 			BUG_ON(!page);
-			mod_memcg_page_state(page, MEMCG_VMALLOC, -step);
-			__free_pages(page, page_order);
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+			/*
+			 * High-order allocs for huge vmallocs are split, so
+			 * can be freed as an array of order-0 allocations
+			 */
+			__free_pages(page, 0);
 			cond_resched();
 		}
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
@@ -2914,12 +2917,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr !=3D nr_pages_request)
 				break;
 		}
-	} else
-		/*
-		 * Compound pages required for remap_vmalloc_page if
-		 * high-order pages.
-		 */
-		gfp |=3D __GFP_COMP;
+	}
=20
 	/* High-order pages or fallback path if "bulk" fails. */
=20
@@ -2933,6 +2931,15 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			page =3D alloc_pages_node(nid, gfp, order);
 		if (unlikely(!page))
 			break;
+		/*
+		 * Higher order allocations must be able to be treated as
+		 * indepdenent small pages by callers (as they can with
+		 * small-page vmallocs). Some drivers do their own refcounting
+		 * on vmalloc_to_page() pages, some use page->mapping,
+		 * page->lru, etc.
+		 */
+		if (order)
+			split_page(page, order);
=20
 		/*
 		 * Careful, we allocate and map page-order pages, but
@@ -2992,11 +2999,10 @@ static void *__vmalloc_area_node(struct vm_struct *=
area, gfp_t gfp_mask,
=20
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	if (gfp_mask & __GFP_ACCOUNT) {
-		int i, step =3D 1U << page_order;
+		int i;
=20
-		for (i =3D 0; i < area->nr_pages; i +=3D step)
-			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC,
-					     step);
+		for (i =3D 0; i < area->nr_pages; i++)
+			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
 	}
=20
 	/*
--=20
2.35.1

