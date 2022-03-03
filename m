Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059834CB5A9
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 05:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiCCEBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 23:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCCEBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 23:01:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C7D15C1AE;
        Wed,  2 Mar 2022 20:00:38 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so3581909pjb.3;
        Wed, 02 Mar 2022 20:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8Wnkngh0cz774oXrOB+djrZJAC791wEW1yD76eU3mA=;
        b=Tp2WvHtquQCKN/tDLzu1vaBVoEQ+o/F9bItG1ZGG3swOGWYolDkUzu1su5OMP5M18y
         8vT4umeQiGvPt6GJ3ToMF1UrPDZNgwgKCcQebodBo5W4KrC/DW4qEVL/qwteae4ShpAC
         CNwF3BgyY7R0G+JD0obJjowxXXKvsBEAPV8Vp1c46PF9UjRWbLCy+90ngloKQlyIIwCO
         F+S8H9CKuXW9j+wwGpetgBmvo2+UFNJver6t9i/ucahV9qccHweFgcz8xVQYAz2OZNPF
         tCqYTYiWNjnB3yKjIPdZaYhY1JB4+zVDwjDhCdEEub+aXiRatMDGmWCyCoK1sYxtFJuF
         MAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8Wnkngh0cz774oXrOB+djrZJAC791wEW1yD76eU3mA=;
        b=kmA/cVwz5rp+2IhKPhhfExmAhqE1nkyh/Ggn50pnQKUb2N6sUMWA7TGvsJz7uTQCoP
         tz5N4XO8NnSkmomwiLpMLW7osIe464Gqo8QTgpF1i2OgaMNq6e5+HRjZglaF+Etnvjgp
         AOltf7UWCvwtwA2CxnHWG3PYq0LytzHjF5iN3zZknH0iUQEC+CavWv0TDtWgGL1Wgu34
         INx0Af96icDU9AmhqpY5rtloz88bGlC98Ygci91tuvSfqjd19QSb2nU1IKCOUHR7O7jL
         a7HC1bFc+mdmHABcIAMmtzbzA8/fgHj8PjKiVTo1ky2RMzrx7sVhYaj69OJmDIuHLQWY
         7y1A==
X-Gm-Message-State: AOAM531ak5ovgJN9tnF2cMnH0S7oSeWOXJ4CLhgHRqDZEYnc1iIs9HcA
        hrdezMhxtp8qumlN/G7/zZi5rgMPGGaiXaEGkQ9wt+Xl
X-Google-Smtp-Source: ABdhPJzbu1Dy1FqOFtzYr8EW+FoeIxo7cnjlM+ZHpIPBnve2rxGtU2v8Z7e3faKFmBw5GYlemnbFs//cDNx1s8RS6e4=
X-Received: by 2002:a17:902:76c5:b0:14e:e325:9513 with SMTP id
 j5-20020a17090276c500b0014ee3259513mr34067029plt.55.1646280038108; Wed, 02
 Mar 2022 20:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-9-haoluo@google.com>
 <20220302224506.jc7jwkdaatukicik@apollo.legion> <f780fc3a-dbc2-986c-d5a0-6b0ef1c4311f@fb.com>
 <20220303030349.drd7mmwtufl45p3u@apollo.legion>
In-Reply-To: <20220303030349.drd7mmwtufl45p3u@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 20:00:26 -0800
Message-ID: <CAADnVQJvbgq3j5SUb3OCbkndgpqeYNAv4Xgo2gOav0mC2f=vmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Mar 2, 2022 at 7:03 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
>
> I think current approach is also not safe if cgroup_id gets reused, right? I.e.
> it only does cgroup_get_from_id in seq_start, not at attach time, so it may not
> be the same cgroup when calling read(2). kernfs is using idr_alloc_cyclic, so it
> is less likely to occur, but since it wraps around to find a free ID it might
> not be theoretical.

cgroupid is 64-bit.
