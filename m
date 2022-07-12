Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824D0572046
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiGLQE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiGLQEw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 12:04:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7208C766F
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:04:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so15107506ejj.12
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OROIHR5qZL9/bZqoAqvRAN1WBpFHFV5HSU9hQpiXWb8=;
        b=Lem2qnRZHsBPFVD2wJm7XUWQccWuus1PVpFimzWkOrDE6u177WNgLnOAlG99uXOYWm
         zFMEgBU0bRUlqZDmH5v3INau7aMmPqDfdoYbFN9BEbyTtZZrBcexVXONJwuJl7PQar25
         CqTZzvPVQGk06vtDn/H1IODbchbG6Ktx8UmgZ2haBrNL6Ka74GCGi2IUO02YaSYOuU6b
         zn9wN/Dril5/obQ9OY+K/2zj4NDiX4vikJ6Vim/rWQTAepZKwYYoHQeq/HVy/5zT6pMB
         4ivWLXUdwZrK4Umj/1nE36jZpvb6e68/zOLZEguX4etEcLFm3xs7mo8bbNSjX+r3HKbE
         qvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OROIHR5qZL9/bZqoAqvRAN1WBpFHFV5HSU9hQpiXWb8=;
        b=iSeEcKMNiEobDVlz3xCL6VoWgcjRoJ3QUj43zOxs/ekSkJdRvR9Qz5kynGwauZSLjw
         0xMWpjKtIzxLyvBGgGpWcl7g9vMjwZTdDXVeuVqGGO2ZXccLb+p/KgJQb/dQ7ktPahb5
         RhRv8rqGofm5dxXURxd/d4iAqV007R1ENnGrd3r4PoahxzYzyWatQTKN8An8HHnRwAjr
         wJldlxFQ0xRpH6G5QmtJTz2DzqoF59VJGFkNmXL8qIHEgO5aSQAt1sK3zs+aH8kSXNAN
         xkHS07cVqq3RSlcXTFw1Sfz4NErYjRi0lKDE/T5Tq+IAZgcOp3jH2/vVLPu80tQFppbt
         Zxvg==
X-Gm-Message-State: AJIora+Zz90H4si0AB9WSGU1nF3tzlhqsWGjNgStqCwZMn896ncReCs2
        CC30oDzlS/xk2gaTKCFOCXV2wp/XPchBx6uHay0=
X-Google-Smtp-Source: AGRyM1sXNuuwtQuyw7Wx/fHg4/iMLd8oO2vpUIecx78nlS2VEWLiyusJMAKnZh9+BnfvqtSq4TLkon9HKreJ3JljSjU=
X-Received: by 2002:a17:907:c14:b0:72b:6762:de34 with SMTP id
 ga20-20020a1709070c1400b0072b6762de34mr8391772ejc.94.1657641878453; Tue, 12
 Jul 2022 09:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
 <CAAYibXj-8jJKOFkKuFHoVbn2nux-CbNH1EF=H4NEdZ76vF1rnQ@mail.gmail.com>
 <CA+khW7gMsE1iqmzibvHUCMUvfD5Rku46GaazwyvktGnHennDxg@mail.gmail.com> <Ys02hDIYZ58kYTNf@krava>
In-Reply-To: <Ys02hDIYZ58kYTNf@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Jul 2022 09:04:27 -0700
Message-ID: <CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsKPckQ@mail.gmail.com>
Subject: Re: Questions about querying map object information
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Hao Luo <haoluo@google.com>,
        "Hao Xiang ." <hao.xiang@bytedance.com>, bpf <bpf@vger.kernel.org>,
        Chuang <horenchuang@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 1:53 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 04:35:19PM -0700, Hao Luo wrote:
> > Hi Hao Xiang,
> >
> > On Mon, Jul 11, 2022 at 3:50 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
> > >
> > > Ping...
> > >
> > > Can someone please help to shed some light on this?
> > >
> > > Thanks, Hao
> > >
> > > On Sun, Jul 3, 2022 at 3:33 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
> > > >
> > > > Hi everyone,
> > > >
> > > > I am super new to bpf and the open source community in general. Please
> > > > bear with me asking some basic questions.
> > > > We are working on a bpf monitoring tool to track the CPU and memory
> > > > usage for all bpf programs loaded in the system. We were able to get
> > > > CPU usage per bpf program with the BPF_OBJ_GET_INFO_BY_ID syscall on a
> > > > bpf prog object. We are trying to do the same on a map object to query
> > > > for per map memory usage. The information returned from bpf_map_info
> > > > only contains things like max_entries, key_size, value_size, which can
> > > > be used to calculate estimated memory allocation size. But we are also
> > > > interested in knowing how much memory is actually being used by our
> > > > program. For instance, one of our bpf program uses a map with type
> > > > hashtable. The hashtable is created with a chunk of pre-allocated
> > > > memory based on the max_entres, key_size and value size. The
> > > > pre-allocated size is useful information to know but so is the current
> > > > number of entries in the hashtable. We used to run into a performance
> > > > issue where our bpf map's max_entries is set to be too small and we
> > > > end up totally exhausting the pre-allocated memory. So knowing things
> > > > like current entry count VS max entry count of a hashtable is useful
> > > > information for us.
> > > > With that being said, we have a few questions and hopefully we can get
> > > > some help from the community.
> > > > 1) We couldn't find anything in bpf_map_info to give us the current
> > > > entry count of a hashtable. I read that bpf_map_info returns
> > > > information about a map object in general. So it makes total sense to
> > > > not have information of a particular map type. But is there an
> > > > existing place we can get the per map type information (eg, the
> > > > current entry count of a hashtable, the number of elements pushed to a
> > > > stack, etc)?
> >
> > cc more BPF experts for their comments.
> >
> > I agree with you that knowing the current space usage of a map is
> > quite helpful. In my understanding, a naive and inefficient way to
> > estimate space usage is iterating the map and counting the map
> > elements. That's doable, but may not be the best method though.
> > Regarding auto-adjusting map size, I remember Andrii talked about
> > resizable hash maps, maybe he can tell you more [1].
>
> we keep entries count for hash map, maybe we could just add
> 'current count' to bpf_map_info, it seems generic enough

We actually don't keep a count for the default case of prealloc.
