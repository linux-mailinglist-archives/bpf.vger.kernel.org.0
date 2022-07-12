Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79C570F0D
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 02:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiGLAqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 20:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiGLAqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 20:46:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A711801
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 17:46:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v187so819355oie.7
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5kMTrqrcfHrmKxG8hArJ37L+VVCpUgbyOgwfhcz1Sw=;
        b=z4TFP5V49s89UIg/I8NR91nyr+bTjZqZmeo0m2947oEIRU7RwhQ2+wtOR4GFCA++ya
         USG19Ba75gbiKvD8YVHzEp4dP5B03vqiHifZ6ENraxmJokihk9gozdSDRuikHeJlrwk7
         qaPur/LN22d13MrK9B2Fgh4lEb/rEjRlmA5FfA0UkNsiIRmjRca0nXesgJ4mKvnCqsnr
         1RsVQM81tOldtXncqF6eoFwIm/8+zYg8Iu3UhOw+zHYG7n+4THKZSHK5Qvyk2xOXTsuv
         XL8YVK0r2UUmJ0pij5myz6xKuh/02yhvA4FcoSvjKWCOawPA+nXWhTbY98+KDXkDE56+
         CCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5kMTrqrcfHrmKxG8hArJ37L+VVCpUgbyOgwfhcz1Sw=;
        b=MzpMWmO0L0WtxQFchDklq+3TpITd/eEV3nmMAIB5yWAuZjDBDPp2W6ypmjX2Fu+BYH
         x+T5hIMlkRykTpQL8Hmy3S1Dffe9r/gII/7cJEa9JBJNtmeUayoy4McwuUePgkzx3u/V
         KqwlwdqlD+KoNdIXpvOE6joAP/5Mc/MXLSxaxqOt7hWSBbTpYoIPI9mjFqqxQOGLVfy9
         KhENpC9JdKkVndmko4vzFSGOz+ulv7ipilPwTxVdvd4pI8qR07tqBTImmClzdkRTCBv8
         9pxCzX3UJKwf25saX9PTZ45ljJ41Y8EZp9MYcCe+rDqhUaDBQFcVlR8ZvAkzjrKuX+4Q
         ZNzQ==
X-Gm-Message-State: AJIora/khR66o/s6Jhn2HV6oF33kjudwf0ylU28TpiAG1z+fkrQjduop
        48Qxrpyr06MLjI0c2bFIVfXeIV/XT8J/EzLntY8ffHjR9xdCjpM9
X-Google-Smtp-Source: AGRyM1vyKotPCRlJSTeSQVU+4vgg884Z4by1hCukBiE7rYt2sBbEhJurNk/x9wdrEj9MtmglPNc/40ufyE3Wz4Zbf4o=
X-Received: by 2002:a05:6808:1928:b0:339:f15a:ec8f with SMTP id
 bf40-20020a056808192800b00339f15aec8fmr638770oib.35.1657586789238; Mon, 11
 Jul 2022 17:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
 <CAAYibXj-8jJKOFkKuFHoVbn2nux-CbNH1EF=H4NEdZ76vF1rnQ@mail.gmail.com> <CA+khW7gMsE1iqmzibvHUCMUvfD5Rku46GaazwyvktGnHennDxg@mail.gmail.com>
In-Reply-To: <CA+khW7gMsE1iqmzibvHUCMUvfD5Rku46GaazwyvktGnHennDxg@mail.gmail.com>
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Mon, 11 Jul 2022 17:46:18 -0700
Message-ID: <CAAYibXj84S1X9w784XWNGupSxnSHKhYT5mWfgdOCVOQZxj7Yig@mail.gmail.com>
Subject: Re: [External] Re: Questions about querying map object information
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, Chuang <horenchuang@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao,

I am not talking to myself :-) Thanks for addressing the question.
Please see inline.

On Mon, Jul 11, 2022 at 4:35 PM Hao Luo <haoluo@google.com> wrote:
>
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
> > I agree with you that knowing the current space usage of a map is
> > quite helpful. In my understanding, a naive and inefficient way to
> > estimate space usage is iterating the map and counting the map
> > elements. That's doable, but may not be the best method though.
> > Regarding auto-adjusting map size, I remember Andrii talked about
> > resizable hash maps, maybe he can tell you more [1].
>
> I agree it's doable to get the map count by iterating through the map. I just
> looked through the code and realized that it's quite heavy doing it that way.
> Basically we will have to make N bpf syscalls where N = used count. Our monitor
> program wants to retrieve the current usage in a higher frequency and the underlying
> cost looks pretty significant. Other than that, is it expected that a user process who
> can do BPF_OBJ_GET_INFO_BY_FD requires the same privilege as someone
> who can do BPF_MAP_GET_NEXT_KEY? I would expect that only the process
> talking to the bpf prog can update/delete/get keys of a map but a process who only
> wants to monitor the prog/map requires less privilege?
>
>
> [1] http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-algs.pdf
>
> > > 2) If there isn't an existing place to return map type specific
> > > information, would it make sense to extend the structure bpf_map_info
> > > with a union at the end and have that union to contain per map type
> > > specific information?
> > >
> > > Thanks, Hao
