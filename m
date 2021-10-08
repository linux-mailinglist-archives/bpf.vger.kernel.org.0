Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889C4427393
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbhJHWWb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 18:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231830AbhJHWWb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 18:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633731635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nzPIcRF7yHK4+23XSiiWLRtQD40Ph9+L4zPFH3eWNgY=;
        b=AcfRS6c0q+csBIQCEhlWpJSSrugNcJzTMiJgRH9IZLoCmF/1VOdsiqWz6jLKA6QmP2cAou
        Agspn7hoVeJH9XgihOyMkA0mPKaC0ppr+zpBf5yFT1RMS6AzmY5ypdrpYD2wpjHA0bjS/I
        pFSGAqNv+wtBGQB8SL1F9jSUTVDV9Gs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-ahbDfnP2PKCTaOuvNeLM-w-1; Fri, 08 Oct 2021 18:20:31 -0400
X-MC-Unique: ahbDfnP2PKCTaOuvNeLM-w-1
Received: by mail-ed1-f69.google.com with SMTP id f4-20020a50e084000000b003db585bc274so4927160edl.17
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 15:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=nzPIcRF7yHK4+23XSiiWLRtQD40Ph9+L4zPFH3eWNgY=;
        b=IoIUhElRhMaPcgMXM9z38TYEih+LtNT9ANbhTBylkFZ1C1awa4TFadqSqaTohpZNow
         9W/DI/HKluP4IUYYMwULQIH7v0X558+nhQAHSUFB/qAB8H6p0c3CvHWWJgA0k0w13mTE
         6MeAIgIV4rXXaJnUu3Hr+MDY/4K4Id1nWaIAsiX+GE/C4DZSBCUsp1bL+AfrRYnLyZuW
         lsD3V6zFj9zaU0wVnz7vH2cy1yeV9iqj/ady2JMBYoe6/XmF0XcR5b52eaghapW29YOJ
         i/hCGQ0UkvtD/OsAUj6In1On5TzkddvVkyNGluhTiuQNHL9CBVqxrZQS5I0RCpJG+bYE
         WFmA==
X-Gm-Message-State: AOAM5309H46avXoIT0Z9zec++ZDuRi6ft5EXPVSyX9zJ4Vf6S/W56Ywi
        tDleCE2Cs3AK1LE2CjTEoqL5MIOUxsWwvWUDW1/nUP0dEwIH5P29V+P2BVYejMIxxOXmPA3hdKM
        gk3+FSb7i1CrF
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr7487299ejq.11.1633731629735;
        Fri, 08 Oct 2021 15:20:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyfQO3e/0f6CMOIsNdneGCdrMjkzpc5iceLZyD/a2EwPJNVkPJglStyNFlyJS/y0RvsnfCmA==
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr7487178ejq.11.1633731628487;
        Fri, 08 Oct 2021 15:20:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d14sm178705ejd.92.2021.10.08.15.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 15:20:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 17D7E180151; Sat,  9 Oct 2021 00:20:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 0/3] Add XDP support for bpf_load_hdr_opt
In-Reply-To: <20211007235203.uksujks57djohg3p@kafai-mbp>
References: <20211006230543.3928580-1-joannekoong@fb.com>
 <87h7dsnbh5.fsf@toke.dk> <9f8c195c-9c03-b398-2803-386c7af99748@fb.com>
 <43bfb0fe-5476-c62c-51f2-a83da9fef659@iogearbox.net>
 <20211007235203.uksujks57djohg3p@kafai-mbp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 09 Oct 2021 00:20:27 +0200
Message-ID: <87lf33jh04.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Thu, Oct 07, 2021 at 11:25:29PM +0200, Daniel Borkmann wrote:
>> I tend to agree with Toke here that this is not generic. What has been tried
>> to improve the verifier instead before submitting the series? It would be much
>> more preferable to improve the developer experience with regards to a generic
>> solution, so that other/similar problems can be tackled in one go as well such
>> as IP options, extension headers, etc.
> It would be nice to improve verifier to recognize it more smoothly.  Would
> love to hear idea how to do it.

So as far as I could tell, the verifier blows up in part because when
there's multiple bounded loops in sequence the verifier gets into a
combinatorial explosion of exploring all paths through the first loop
combined with all paths through the second. So if we could teach the
verifier to recognise that each loop is a separate entity to avoid this,
I think looping through headers would be a lot easier.

As you can probably tell, though, there is quite a bit of handwaving in
the above, and I have no idea how to actually do this. Some kind of
invariant analysis, maybe? But is this possible in general?

> When adding the tcp header options for bpf_sockops, a bpf_store_hdr_opt()
> is needed to ensure the header option is sane.  When writing test to parse
> variable length header option, I also pulled in tricks (e.g. "#pragma unroll"
> is easier to get it work.  Tried bounded loop but then hits max insns and
> then moved some cases into subprog...etc).  Most (if not all) TCP headers
> has some options (e.g. tstamp), so it will be useful to have an easy way
> to search a particular option and bpf_load_hdr_opt() was also added to
> bpf_sockops.

So if we can't fix the verifier, maybe we could come up with a more
general helper for packet parsing? Something like:

bpf_for_each_pkt_chunk(ctx, offset, callback_fn, callback_arg)
{
  ptr = ctx->data + offset;
  while (ptr < ctx->data_end) {
    offset = callback_fn(ptr, ctx->data_end, callback_arg);
    if (offset == 0)
      return 0;
    ptr += offset;
  }
  
  // out of bounds before callback was done
  return -EINVAL;
}
   
This would work for parsing any kind of packet header or TLV-style data
without having to teach the kernel about each header type. It'll have
quite a bit of overhead if all the callbacks happen via indirect calls,
but maybe the verifier can inline the calls (or at least turn them into
direct CALL instructions)?

-Toke

