Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108E0570D8C
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiGKWuk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiGKWuj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 18:50:39 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD7564F7
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 15:50:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10c0430e27dso8435720fac.4
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXXVgM4b1b/KaEIZ/UjhLHZV1IdNIqhRXeBVoQ83rV0=;
        b=B40qnXxugKk669HccEH2bVTPLRPeViRmkp09R4e0qNc4bmVVfCJYIBoEKXuWEdJOBM
         5eoLiH+fAQsSqdkxCWK2iI14kzzHw0PRxF/6KDzivEzPiWIyUAW1BLEY29pkbZqoyMKK
         2aj8xYYl5xh0pYgg61T+HX55GcZaD8bIMlt92dLXS+XLaU1CWFFICba/IjJ0TQvF/sBC
         8hAuUPXiGzmsHQ5zh1dZ09nD7zWMkboCcuylD2vcwZVgK2eGG7/W080tvoAPG9sMa1p7
         gNQ5RdjfFTEMNaw25k8lNMei4L6Wu02/qQ4apA/dFc1lvncY8cJFl/wKM6nQgvCQrFH6
         YGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXXVgM4b1b/KaEIZ/UjhLHZV1IdNIqhRXeBVoQ83rV0=;
        b=JhWKSvMz3SlrCKe/Gq5Vk8W48WzEYiRux7j73ESbPhbzD0r7F637T9qEBi8TSVHWcH
         Ij4mOSPMQuuEvhjcD4fn/IsVeEIWTWegq8aKyiCjjLk+tE6t8hcqxW3wY2MfZv5sEdxT
         sFEhPiigiXNggThKJNJLSoFAoJaVCYkZXxqhuNCL4VPQqmtjvaqciKckZKkblZOnPjOb
         5Xmf4d0JvmBHAACbST0yJjhbWAfNIWp3Mut/8SjJ9S24duKLx0Of0NM10Ny6OffIHL33
         lyL0y430SGQLkNSgqTCQ4aZndMRX/6MfABdrOhhvt6C/zUNDqEh0YuLOOrNcr0JXAqOV
         lupQ==
X-Gm-Message-State: AJIora/dgKT60f1XywJVvgTf/y9/hu2tE8PJYAqF3ey7kwjrVqMBK5rG
        02TYa0l7vD0UggfRdBE03XfPsm+ThLo5b5bxIPEC1d6li68=
X-Google-Smtp-Source: AGRyM1tJuOmt/e3KaLbs4vmK2UTy2l9s/jmThCyak3uW9LZc0tK0/jTi7CnLKWdqOVk3cqKlbVFcqDmKnB1/mlwmJUg=
X-Received: by 2002:a05:6870:8186:b0:10c:2ed:44f9 with SMTP id
 k6-20020a056870818600b0010c02ed44f9mr347728oae.35.1657579836927; Mon, 11 Jul
 2022 15:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
In-Reply-To: <CAAYibXiJTyGwXZf8h4tTJSFyP8dB5_4sjGDrr=Ag4fe4KA71rA@mail.gmail.com>
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Mon, 11 Jul 2022 15:50:25 -0700
Message-ID: <CAAYibXj-8jJKOFkKuFHoVbn2nux-CbNH1EF=H4NEdZ76vF1rnQ@mail.gmail.com>
Subject: Re: Questions about querying map object information
To:     bpf@vger.kernel.org
Cc:     Chuang <horenchuang@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ping...

Can someone please help to shed some light on this?

Thanks, Hao

On Sun, Jul 3, 2022 at 3:33 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
>
> Hi everyone,
>
> I am super new to bpf and the open source community in general. Please
> bear with me asking some basic questions.
> We are working on a bpf monitoring tool to track the CPU and memory
> usage for all bpf programs loaded in the system. We were able to get
> CPU usage per bpf program with the BPF_OBJ_GET_INFO_BY_ID syscall on a
> bpf prog object. We are trying to do the same on a map object to query
> for per map memory usage. The information returned from bpf_map_info
> only contains things like max_entries, key_size, value_size, which can
> be used to calculate estimated memory allocation size. But we are also
> interested in knowing how much memory is actually being used by our
> program. For instance, one of our bpf program uses a map with type
> hashtable. The hashtable is created with a chunk of pre-allocated
> memory based on the max_entres, key_size and value size. The
> pre-allocated size is useful information to know but so is the current
> number of entries in the hashtable. We used to run into a performance
> issue where our bpf map's max_entries is set to be too small and we
> end up totally exhausting the pre-allocated memory. So knowing things
> like current entry count VS max entry count of a hashtable is useful
> information for us.
> With that being said, we have a few questions and hopefully we can get
> some help from the community.
> 1) We couldn't find anything in bpf_map_info to give us the current
> entry count of a hashtable. I read that bpf_map_info returns
> information about a map object in general. So it makes total sense to
> not have information of a particular map type. But is there an
> existing place we can get the per map type information (eg, the
> current entry count of a hashtable, the number of elements pushed to a
> stack, etc)?
> 2) If there isn't an existing place to return map type specific
> information, would it make sense to extend the structure bpf_map_info
> with a union at the end and have that union to contain per map type
> specific information?
>
> Thanks, Hao
