Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19AE50ACAC
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 02:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiDVAPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 20:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiDVAPO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 20:15:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27DDF14;
        Thu, 21 Apr 2022 17:12:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j8so7208565pll.11;
        Thu, 21 Apr 2022 17:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=n9spvq7TwjTCmocegzLrVuaG32FfqVRthc5ZB6dLUV8=;
        b=O61KrbrRUGJSIracs+yjM6jCeGXb+3yuTWicVrZNxIwk2aUu+uAviMrDAxeVFNL+nd
         W4MOZAQ0kYvM5t/CPFrFbovMgmZ6zU2JdAYWfii9iazZUu/v1tn0Bqnw0S+eRfqKn6k2
         lY32Tm8JWxxPGkPm96oRns97TlOEfoeWs43XUsdvcGEecSOGZKoUqKsleO0MGzGz1BJ5
         pS/Jg0UZ07raSmm4sD1BCirn0dE5vhad4SqO6EcTgFarMZqKX0GgSO9UChHq0CIPyaI8
         m21oie+OTllp/NvlppdyXPA/AAtVTxhRSrk7pSHJtxmW8HV0XhT9dzJckFCibpwN+7Rp
         1mPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=n9spvq7TwjTCmocegzLrVuaG32FfqVRthc5ZB6dLUV8=;
        b=v2lF8OWW2iw7YDbSd2RxPAZRA5baUiC/zcryBCdZduz7S09eZekngS2TuD47HCGT8/
         Ut4+mvXwy19CNydDb45RdEKIWBvOIq3EqgEjO+O1ADK6j3x+viEiovjbyG7orkMy/Zo4
         ho5hUxfNdEDC1R2Lh/JKz/XquM9cpkgQB3Op59KHiBmvPQkgCaD0Za1N5ekLgIlRARsD
         s+VO6SPNjDtwWHpQdGwE10A2ZOR/H7U108Q+HvaDg8UaW/9DlO58R3+6pqsRcE/gYGVI
         hoXbfaZpWvMjp7rDweqTU30wbzPKhTCnzM/6BYEJOqv/Ae7zQTc12rmbYqT/OKu4LLQ4
         XeVA==
X-Gm-Message-State: AOAM5313Nuy4RRH/STaiCoIp+J1ndqCnkzbVn+Z4KUs6OXmVyP11Z9uQ
        bTDO3VpLdqmxhhktDCJyrrU=
X-Google-Smtp-Source: ABdhPJzpFuAKgrhnbLMYWC1VN4rdDikErr7Bg4HeNegjbto++F7vTsXUinBbonzlZi6dhq3c+teS6g==
X-Received: by 2002:a17:902:c1ca:b0:159:208:7579 with SMTP id c10-20020a170902c1ca00b0015902087579mr2017422plc.30.1650586343131;
        Thu, 21 Apr 2022 17:12:23 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm3554546pjv.2.2022.04.21.17.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 17:12:22 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:12:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
In-Reply-To: <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1650584815.0dtcbd4qky.astroid@bobo.none>
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

Excerpts from Linus Torvalds's message of April 22, 2022 2:15 am:
> On Thu, Apr 21, 2022 at 8:47 AM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
>>
>>                 I wonder if it
>> might have to do with the vmalloc huge pages using compound pages, then
>> some caller doing vmalloc_to_page() and getting surprised with what
>> they could get away with in the struct page.
>=20
> Very likely. We have 100+ users of vmalloc_to_page() in random
> drivers, and the gpu code does show up on that list.
>=20
> And is very much another case of "it's always been broken, but
> enabling it on x86 made the breakage actually show up in real life".

Okay that looks like a valid breakage. *Possibly* fb_deferred_io_fault()
using pages vmalloced to screen_buffer? Or a couple of the gpu drivers
are playing with page->mapping as well, not sure if they're vmalloced.

But the fix is this (untested at the moment). It's not some fundamental=20
reason why any driver should care about allocation size, it's a simple=20
bug in my code that missed that case. The whole point of the design is=20
that it's transparent to callers!

Thanks,
Nick

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e163372d3967..70933f4ed069 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2925,12 +2925,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
                        if (nr !=3D nr_pages_request)
                                break;
                }
-       } else
-               /*
-                * Compound pages required for remap_vmalloc_page if
-                * high-order pages.
-                */
-               gfp |=3D __GFP_COMP;
+       }
=20
        /* High-order pages or fallback path if "bulk" fails. */
=20
@@ -2944,6 +2939,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
                        page =3D alloc_pages_node(nid, gfp, order);
                if (unlikely(!page))
                        break;
+               /*
+                * Higher order allocations must be able to be treated as
+                * indepdenent small pages by callers (as they can with
+                * small page allocs).
+                */
+               if (order)
+                       split_page(page, order);
=20
                /*
                 * Careful, we allocate and map page-order pages, but

