Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6BD571519
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiGLIxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 04:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLIxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 04:53:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8AA9E44
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 01:53:29 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r18so9212531edb.9
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bnBHD+IQVExXc9onsP4jd0+koAliEHd/GZVM3YZkATc=;
        b=fkKKA1BXRfYzNo/PFUiU2Q9SPipa6agzuau8yGRNSHdUdYhHWDTQ4i0AodvjDeSF6v
         F7mj3C4Ob/ON5WvvgzkasaH/4A9KdrYv8XJkhXOcrm9qBCtx3Qamuxx7pfU+woxs+rMp
         bN1xtR8hORWOmMDC+gXqfnAPnAMPws6y0g1q9diTFe/udz+jIGsc+NIwKU7okM3rC4gZ
         039T8+yFnxdAdQZQYa5TE/24+Y1vNW9wTImoZbp5NayEAsyGFMtU6F8mYfybL1n4Y+Wg
         R2GcfMxQXVDVZ6xOMealrDA7RVsbZK1jD76tZVTTtq2tFqSQxDTG4Z7kz1eDjQlbA/nC
         i/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bnBHD+IQVExXc9onsP4jd0+koAliEHd/GZVM3YZkATc=;
        b=DGN1WBc8jCxb2ZHTNG+9KidKFt0FgPCyVOP0UlTiPxzG4wcUEO7sViBKyByDRFHevj
         sFFbrdyYZBmwsA82Ody9Lr1sZF4T6LMLzi1Ix+jc3pYUPoNeeJ2gF6Upesytllm1jsqK
         KnJW6O1fSPbiZiDrV8MTvP0dRqMsfu6B6/6h56UbnaROShPv4t9WYHcDtZLT66IKYClY
         i4Ul8FiEGpes2BpOdPpeMu6Zd/k8XjoJi8d8F9plzA4G/dYdKl0Uti/btQMJEu9XsyGC
         e3HurogLqDjbBeckWrfWYh3RPtfv3m1LAIdNh4zCLr4aXIU2ABlxnJGtuL+UTenk9YJg
         i/EQ==
X-Gm-Message-State: AJIora/bj3WJM6yo/yMfkPzKJwE4s4T6LM47U+fvHSHtjX/PmH/vnxAw
        QSCzLlXI7p2ZDLh+c37GcKo=
X-Google-Smtp-Source: AGRyM1tvf7Hw6EFdCqtkTDg6EdzYRYvIOejm2Q6NatX2YHGS4aoX8yOBr53nDI81ZEABYqbtArUM5w==
X-Received: by 2002:a05:6402:5508:b0:43a:896e:8edd with SMTP id fi8-20020a056402550800b0043a896e8eddmr29920134edb.203.1657616007978;
        Tue, 12 Jul 2022 01:53:27 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id j21-20020aa7c415000000b0043589eba83bsm5681282edq.58.2022.07.12.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 01:53:27 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 12 Jul 2022 10:53:24 +0200
To:     Hao Luo <haoluo@google.com>
Cc:     "Hao Xiang ." <hao.xiang@bytedance.com>, bpf@vger.kernel.org,
        Chuang <horenchuang@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: Questions about querying map object information
Message-ID: <Ys02hDIYZ58kYTNf@krava>
References: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
 <CAAYibXj-8jJKOFkKuFHoVbn2nux-CbNH1EF=H4NEdZ76vF1rnQ@mail.gmail.com>
 <CA+khW7gMsE1iqmzibvHUCMUvfD5Rku46GaazwyvktGnHennDxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7gMsE1iqmzibvHUCMUvfD5Rku46GaazwyvktGnHennDxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 04:35:19PM -0700, Hao Luo wrote:
> Hi Hao Xiang,
> 
> On Mon, Jul 11, 2022 at 3:50 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
> >
> > Ping...
> >
> > Can someone please help to shed some light on this?
> >
> > Thanks, Hao
> >
> > On Sun, Jul 3, 2022 at 3:33 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
> > >
> > > Hi everyone,
> > >
> > > I am super new to bpf and the open source community in general. Please
> > > bear with me asking some basic questions.
> > > We are working on a bpf monitoring tool to track the CPU and memory
> > > usage for all bpf programs loaded in the system. We were able to get
> > > CPU usage per bpf program with the BPF_OBJ_GET_INFO_BY_ID syscall on a
> > > bpf prog object. We are trying to do the same on a map object to query
> > > for per map memory usage. The information returned from bpf_map_info
> > > only contains things like max_entries, key_size, value_size, which can
> > > be used to calculate estimated memory allocation size. But we are also
> > > interested in knowing how much memory is actually being used by our
> > > program. For instance, one of our bpf program uses a map with type
> > > hashtable. The hashtable is created with a chunk of pre-allocated
> > > memory based on the max_entres, key_size and value size. The
> > > pre-allocated size is useful information to know but so is the current
> > > number of entries in the hashtable. We used to run into a performance
> > > issue where our bpf map's max_entries is set to be too small and we
> > > end up totally exhausting the pre-allocated memory. So knowing things
> > > like current entry count VS max entry count of a hashtable is useful
> > > information for us.
> > > With that being said, we have a few questions and hopefully we can get
> > > some help from the community.
> > > 1) We couldn't find anything in bpf_map_info to give us the current
> > > entry count of a hashtable. I read that bpf_map_info returns
> > > information about a map object in general. So it makes total sense to
> > > not have information of a particular map type. But is there an
> > > existing place we can get the per map type information (eg, the
> > > current entry count of a hashtable, the number of elements pushed to a
> > > stack, etc)?
> 
> cc more BPF experts for their comments.
> 
> I agree with you that knowing the current space usage of a map is
> quite helpful. In my understanding, a naive and inefficient way to
> estimate space usage is iterating the map and counting the map
> elements. That's doable, but may not be the best method though.
> Regarding auto-adjusting map size, I remember Andrii talked about
> resizable hash maps, maybe he can tell you more [1].

we keep entries count for hash map, maybe we could just add
'current count' to bpf_map_info, it seems generic enough

jirka

> 
> [1] http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-algs.pdf
> 
> > > 2) If there isn't an existing place to return map type specific
> > > information, would it make sense to extend the structure bpf_map_info
> > > with a union at the end and have that union to contain per map type
> > > specific information?
> > >
> > > Thanks, Hao
