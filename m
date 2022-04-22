Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80B150AE82
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 05:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384651AbiDVDgG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 23:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 23:36:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943041627;
        Thu, 21 Apr 2022 20:33:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so8016977plk.8;
        Thu, 21 Apr 2022 20:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=iEvjNri7DPZ9ItG4XGZ9YPg2UHpVLKH81mxJqNaUcj0=;
        b=Aq60mgyBoX2mT/QLPnHbxI46zNvEmsTfo/Tli60lN72v6jC7DT0j3zONy0ZgiY7Qyl
         z8jdeaAq5R2gKC+ImMVe+c/PV+VSe8V7y0klC7p8JOpqhMjVl3QzxI3Feubga3nGaxKz
         qhMOU9APAVCNoGPnfIXjHNlZ17Q9blfL0l6sgwwZaVPqz8bz6R19e54+bbCV1mrNlEUD
         bjEvasU7pf2iHzVZuJ8byn3CnoX4Ik84oRFdyx6+HKAteKc43dL0StFBTOjL/9i39j5w
         zFwmn+iyDuV/occq8YhdWsFjsZh/8VRJxgoXtbp2qc6cHaGKl9rbI3eSX3iW70yhW52i
         oA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=iEvjNri7DPZ9ItG4XGZ9YPg2UHpVLKH81mxJqNaUcj0=;
        b=zGBdz7OjCgQ2OiZTrsc7OJ0BzRlvDrdvInO9X58yavXIvi+oozBLagcPrq4AJXor1Q
         pLYfJimN8K0Y0Cu4SppbkUVIQ5thKTa3+RgAkB1ZN917927yIn9nL8TlMaPRjr/H5NNj
         pc5qi+R0rPUFeLMwjiTtN4wOuaqdCRVdNO93RYKaNyr0xkHu/QnPAW+yLz/12lxsAH1/
         /0z7bnQuJyDyh63gKjoGVuBH5A6SYYKwBIj2skUB/kbUAuqTc80tDPY1qPYMctR3Lp+7
         feiO/+kZe9x2G3LoQcQG4F0Obx1Yczjet/Z8LGXKq2LFsH4SjJJNP83joZ+7cTFVSx8b
         akiw==
X-Gm-Message-State: AOAM5307TgRglGSv1KLqgrLiwwD8I0EnKClAVmNs+m/VfyvdNFr1GtQO
        wPxtnmj9SbMi2LVLucWZ84w=
X-Google-Smtp-Source: ABdhPJx7lRL9QK5ePoso16IgWMANaKMb/6OwG5jyhWsIxEKtOYH2BOzG7LiP9ICqEPaIN/Tr9+8Xng==
X-Received: by 2002:a17:90b:2786:b0:1d5:bfa1:c7f4 with SMTP id pw6-20020a17090b278600b001d5bfa1c7f4mr3031548pjb.101.1650598392956;
        Thu, 21 Apr 2022 20:33:12 -0700 (PDT)
Received: from localhost (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id f187-20020a6251c4000000b005058e59604csm562092pfb.217.2022.04.21.20.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 20:33:11 -0700 (PDT)
Date:   Fri, 22 Apr 2022 13:33:07 +1000
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
In-Reply-To: <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
MIME-Version: 1.0
Message-Id: <1650598153.250diijyao.astroid@bobo.none>
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

Excerpts from Edgecombe, Rick P's message of April 22, 2022 12:29 pm:
> On Fri, 2022-04-22 at 10:12 +1000, Nicholas Piggin wrote:
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index e163372d3967..70933f4ed069 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -2925,12 +2925,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>                         if (nr !=3D nr_pages_request)
>>                                 break;
>>                 }
>> -       } else
>> -               /*
>> -                * Compound pages required for remap_vmalloc_page if
>> -                * high-order pages.
>> -                */
>> -               gfp |=3D __GFP_COMP;
>> +       }
>> =20
>>         /* High-order pages or fallback path if "bulk" fails. */
>> =20
>> @@ -2944,6 +2939,13 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>>                         page =3D alloc_pages_node(nid, gfp, order);
>>                 if (unlikely(!page))
>>                         break;
>> +               /*
>> +                * Higher order allocations must be able to be
>> treated as
>> +                * indepdenent small pages by callers (as they can
>> with
>> +                * small page allocs).
>> +                */
>> +               if (order)
>> +                       split_page(page, order);
>> =20
>>                 /*
>>                  * Careful, we allocate and map page-order pages, but
>=20
> FWIW, I like this direction. I think it needs to free them differently
> though? Since currently assumes they are high order pages in that path.
> I also wonder if we wouldn't need vm_struct->page_order anymore, and
> all the places that would percolates out to. Basically all the places
> where it iterates through vm_struct->pages with page_order stepping.

To respond to this, I do like having the huge page indicator in
/proc/vmallocinfo. Which is really the only use of it. I might just
keep it in for now.

Thanks,
Nick
