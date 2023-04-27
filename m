Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E36F03D5
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbjD0J61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243445AbjD0J6Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 05:58:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3171BC5;
        Thu, 27 Apr 2023 02:58:24 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef8aaf12bdso35177926d6.3;
        Thu, 27 Apr 2023 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682589503; x=1685181503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5H4urfMx4Jh2e9EbQKPkIyXjRe2bh/qiE1leyX/3eWw=;
        b=ZZ4KYW4275a1rgyrsslbI7/3BzMp2MIeDquIgk3X8jaeJ1B+fKh7sTOfSzsiodmmP9
         pO/XqdQWyUwE60nK72vKdRvGvU935a23v2EmrkspzAptxdj+eds0XbQxbQs3vfElNMe7
         AH7gOE4+u691GNUIBO10Vuuqy7G1jhEaQcmQoSFWVAdkWCDDLdxLyOc7btvypV3VoRJ/
         AnzZIn7D3C5LZ/HxVZRieXTG3Rb7DQRtSU03RIXFKTMCVKOSfdvu8CyPhsj1HJ0YWwEH
         q6yz8sL4uDFcSJ4elutLXi7PSNC2oxRn1UFlacEzUgHr06JClFNv+KA0bdH8Jj8qVuUe
         cDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682589503; x=1685181503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H4urfMx4Jh2e9EbQKPkIyXjRe2bh/qiE1leyX/3eWw=;
        b=Xo0F8GBuZGkHnTVFbSZCh5oGpcS9x1DoiymVx01tKSeAzxsR3p0nndSOzL1UzourKp
         7hL6WayRXonbo21hhlDenynjZDVIHr9GNAEfAbs62e0wBbHiH6wPKrN1iAzMVdGbbCdP
         t/L4HYVGP4BwybmiOz9hJQMyN/JYyrSHsLNCr782Nf1wv8CdnGzZG7SdQb3r1LxjyGdp
         k1AtVR3u5NzYOZvefIYXoeiutiERfdHIRG1ZUCltlJxrknBTXjz2QUop1nySjAFI2jAz
         lFnVh2Qz0wa07+BB7Z3vFi0BSgQxax510LTUuUwGRtd+racpOuPGc00EabOt4lo00Ktu
         cmHA==
X-Gm-Message-State: AC+VfDySbNeZs4/kg//hugK3JT2ZuJ2go39F/01Q8pIEl/un8iRrTPbG
        PKUu/aBRg4Y6CjObUTovQJ62imjVX3henF2x/easWpTcufBvZg==
X-Google-Smtp-Source: ACHHUZ5u74XYCV+RmAscIBZt0+JZKqc5mfORjXgiD4PA4KTJH2oLwAvfseKa73Y6mOzKOm7PyHO6nDmyeKz+eXPMAbc=
X-Received: by 2002:a05:6214:2589:b0:5f1:6bee:f58e with SMTP id
 fq9-20020a056214258900b005f16beef58emr885006qvb.35.1682589503483; Thu, 27 Apr
 2023 02:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230417201457.c43xfcukjzm4u6vx@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CALOAHbC4Bz_VX52zmv=sScBf0hzscMAC4+EwMCpnd1BcaSVJSw@mail.gmail.com>
 <CAADnVQJw9BCK2itE5bZWdQYz7D-8KdcH96E885zUakEDAOrC+Q@mail.gmail.com>
 <CALOAHbCtPR26it_Wdk7T_TETMTh2se6rgEbL_KC5XKtzvObjiA@mail.gmail.com>
 <CAADnVQ+FO-+1OALTtgVkcpH3Adc6xS9qjzORyq2vwVtwY2UoxQ@mail.gmail.com> <20230424174049.1c9e54dd@rorschach.local.home>
In-Reply-To: <20230424174049.1c9e54dd@rorschach.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Apr 2023 17:57:47 +0800
Message-ID: <CALOAHbAx+W3-iBS6=FsPPShbEuSSZeyQWvLque+uF9Suwe3-HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 5:40=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 19 Apr 2023 15:46:34 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > No. Just one prog at entry into any of the kernel functions
> > and another prog at entry of funcs that 1st bpf prog called indirectly.
> > Like one prog is tracing networking events while another
> > is focusing on mm. They should not conflict.
>
> You mean that you have:
>
> function start:
>   __bpf_prog_enter_recur()
>     bpf_program1()
>       __bpf_prog_enter_recur()
>         bpf_program2();
>       __bpf_prog_exit_recur()
>   __bpf_prog_exit_recur()
>
>   rest of function
>
> That is, a bpf program can be called within another bpf pogram between
> the prog_enter and prog_exit(), that is in the same context (normal,
> softirq, irq, etc)?
>

Right, that can happen per my verification. Below is a simple bpf
program to verify it.

struct {
    __uint(type, BPF_MAP_TYPE_LPM_TRIE);
    __type(key, __u64);
    __type(value, __u64);
    __uint(max_entries, 1024);
    __uint(map_flags, BPF_F_NO_PREALLOC);
} write_map SEC(".maps");

__u64 key;

SEC("fentry/kernel_clone")
int program1()
{
    __u64 value =3D 1;

    bpf_printk("before update");
    // It will call trie_update_elem and thus trigger program2.
    bpf_map_update_elem(&write_map, &key, &value, BPF_ANY);
    __sync_fetch_and_add(&key, 1);
    bpf_printk("after update");
    return 0;
}

SEC("fentry/trie_update_elem")
int program2()
{
    bpf_printk("trie_update_elem");
    return 0;
}

The result as follows,

         kubelet-203203  [018] ....1  9579.862862:
__bpf_prog_enter_recur: __bpf_prog_enter_recur
         kubelet-203203  [018] ...11  9579.862869: bpf_trace_printk:
before update
         kubelet-203203  [018] ....2  9579.862869:
__bpf_prog_enter_recur: __bpf_prog_enter_recur
         kubelet-203203  [018] ...12  9579.862870: bpf_trace_printk:
trie_update_elem
         kubelet-203203  [018] ....2  9579.862870:
__bpf_prog_exit_recur: __bpf_prog_exit_recur
         kubelet-203203  [018] ...11  9579.862870: bpf_trace_printk:
after update
         kubelet-203203  [018] ....1  9579.862871:
__bpf_prog_exit_recur: __bpf_prog_exit_recur

Note that we can't trace __bpf_prog_enter_recur and
__bpf_prog_exit_recur, so we have to modify the kernel to print them.

> The protection is on the trampoline where the bpf program is called.
> Not sure how ftrace can stop BPF or BPF stop ftrace, unless bpf is
> tracing a ftrace callback, or ftrace is tracing a bpf function.
>
> -- Steve



--=20
Regards
Yafang
