Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07064570E54
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 01:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGKXfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 19:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGKXfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 19:35:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B02B18A
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 16:35:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id m6so1490557qvq.10
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ok7we0d5RfoFBDnLxZbCnUUm9gVO9QqlTpbg52X5BzA=;
        b=gzI7lsVEq8AHroKD6ksIwtTHWpIuOepat89apSa7XJ94ZfuPIKeyGufeXUBRBTPRMu
         fABONVDkdkV2XLPl0trLYtNmUQBmoMDE9UsobdYKHaGTIzKzxMuJsq2sw12baeqrPgV4
         PdkhTq0sjk/Fj5texojVXl4DqSKgdjL1dXNmPvg2QBA5pdfdrx52EJYKrb8eJqk3Nzom
         7oRujL4Cm9hcG2KiXGZ8F+m2Gr5XncDCsVZQk4mQDSVygGZyX4CYPxZcTdLMjHy926Lg
         EH6hC9TkqOv4HsRAVjyOeBxkO8FuwBldCKEbtkD7c/QKFVxOaFvFLJ3kLG8eFsJKWLZi
         Xlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ok7we0d5RfoFBDnLxZbCnUUm9gVO9QqlTpbg52X5BzA=;
        b=ECbbiJYPYrNe0P8F8Gg8ZLNOO//EyvLS75U5PtabMqjpqhHmA5Bw5SrY6b1Y0XviIf
         CXV/mQZIY2nKw+zVeTFNGxhwgsccCFBSbBIGJKESIbMm9Pa1UESF7VZE17YCJL45eyl8
         WukQzPNGdVvGBKTHHNuGMm1e5u6mmj2jmyKZa2vndAY6OLgE7GTp3aPaHn+BETTysX/d
         zAmoOXUWfONtrSeQY2Yl5CpcpfAn7hFKx4KqGd+OZiU/lLNUD+m4RY6qtb52XzyM+AbI
         g0AW4KKbfIiKQZwdg7dZYvi45tWKUceZVOckriSJakcLWyO6kVBMq5Ti1DZAkABjHkKn
         Z/xw==
X-Gm-Message-State: AJIora99sy8/qYOZaisLvsIbK2i/zrUP9ImlqmsaNcwy50MwBVrRwvac
        UTZURdO1R9U9dI1kk2l3htjH/SkYBOr5QXtc8mshDQ==
X-Google-Smtp-Source: AGRyM1tRe4fxmvkjEnFLptEYWShjbrkbzwQIxm0ziUdySzzQrN+gaE3Qv0vECaG2BARe6H4dADboK2CHDo/FgS9i314=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr15773269qvf.35.1657582530544; Mon, 11
 Jul 2022 16:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
 <CAAYibXj-8jJKOFkKuFHoVbn2nux-CbNH1EF=H4NEdZ76vF1rnQ@mail.gmail.com>
In-Reply-To: <CAAYibXj-8jJKOFkKuFHoVbn2nux-CbNH1EF=H4NEdZ76vF1rnQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jul 2022 16:35:19 -0700
Message-ID: <CA+khW7gMsE1iqmzibvHUCMUvfD5Rku46GaazwyvktGnHennDxg@mail.gmail.com>
Subject: Re: Questions about querying map object information
To:     "Hao Xiang ." <hao.xiang@bytedance.com>
Cc:     bpf@vger.kernel.org, Chuang <horenchuang@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Hao Xiang,

On Mon, Jul 11, 2022 at 3:50 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
>
> Ping...
>
> Can someone please help to shed some light on this?
>
> Thanks, Hao
>
> On Sun, Jul 3, 2022 at 3:33 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
> >
> > Hi everyone,
> >
> > I am super new to bpf and the open source community in general. Please
> > bear with me asking some basic questions.
> > We are working on a bpf monitoring tool to track the CPU and memory
> > usage for all bpf programs loaded in the system. We were able to get
> > CPU usage per bpf program with the BPF_OBJ_GET_INFO_BY_ID syscall on a
> > bpf prog object. We are trying to do the same on a map object to query
> > for per map memory usage. The information returned from bpf_map_info
> > only contains things like max_entries, key_size, value_size, which can
> > be used to calculate estimated memory allocation size. But we are also
> > interested in knowing how much memory is actually being used by our
> > program. For instance, one of our bpf program uses a map with type
> > hashtable. The hashtable is created with a chunk of pre-allocated
> > memory based on the max_entres, key_size and value size. The
> > pre-allocated size is useful information to know but so is the current
> > number of entries in the hashtable. We used to run into a performance
> > issue where our bpf map's max_entries is set to be too small and we
> > end up totally exhausting the pre-allocated memory. So knowing things
> > like current entry count VS max entry count of a hashtable is useful
> > information for us.
> > With that being said, we have a few questions and hopefully we can get
> > some help from the community.
> > 1) We couldn't find anything in bpf_map_info to give us the current
> > entry count of a hashtable. I read that bpf_map_info returns
> > information about a map object in general. So it makes total sense to
> > not have information of a particular map type. But is there an
> > existing place we can get the per map type information (eg, the
> > current entry count of a hashtable, the number of elements pushed to a
> > stack, etc)?

cc more BPF experts for their comments.

I agree with you that knowing the current space usage of a map is
quite helpful. In my understanding, a naive and inefficient way to
estimate space usage is iterating the map and counting the map
elements. That's doable, but may not be the best method though.
Regarding auto-adjusting map size, I remember Andrii talked about
resizable hash maps, maybe he can tell you more [1].

[1] http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-algs.pdf

> > 2) If there isn't an existing place to return map type specific
> > information, would it make sense to extend the structure bpf_map_info
> > with a union at the end and have that union to contain per map type
> > specific information?
> >
> > Thanks, Hao
