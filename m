Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3794CD33D
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2019 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJFPwO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 6 Oct 2019 11:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfJFPwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Oct 2019 11:52:14 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBE2D85541
        for <bpf@vger.kernel.org>; Sun,  6 Oct 2019 15:52:13 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id m81so2821894lje.4
        for <bpf@vger.kernel.org>; Sun, 06 Oct 2019 08:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NJk0TgN5l03FJDVMnl8JvmDEfmBwLpkYZe0sUOBEo6I=;
        b=Zjk71gCQBFC+Tx9OeqsRLl/lCr8J4GfjmJZ8LQ4pnzF8jilFCD4NhktMLooS6sHgB/
         GDLr9G/z4gj4psoC6Wt6A7lQNYb7+AyqEE0OU1Z6unXnx/qovBxVHn/r/mTIrnTO3xCs
         8+tZZPf9jXVnaqBP8ohm9clUgTuZmvhjYQ+evTh5AsY6RKNW5jb4ZvjMtE9FzD7/5xbE
         L31U6lVnXIFGvy61f1Hm0FLXJZEc73WnDfNbVWPEB37zaut7UyVG2B3W+s0RI7w4JhXj
         1PCwnlEn/T6h6sbHlPYPSMZpZQMix0g2nmkkNH6pHGNtfM/xvuYFysZfX7dKxgIv0agt
         qyww==
X-Gm-Message-State: APjAAAVILdPsv/JN6QgsWyecOJN0l7K7pbMdQA+yne4dMvT9rnhIV29Z
        ZJK7ym6OtVAVdwdklwo3CyKq07gdE/MTHNITpouASUZt11p/ET+hlhh25W/FgY5A7sASc/vXWrx
        SQ0atk5WY4wGb
X-Received: by 2002:a2e:9748:: with SMTP id f8mr13954480ljj.167.1570377132309;
        Sun, 06 Oct 2019 08:52:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1pkfN4M+fG8xJse3sP2f0ROS32sPBMlsAJUIyMrNlJx/V8uqSqEuW7A7GQziZJcD+Vftwbg==
X-Received: by 2002:a2e:9748:: with SMTP id f8mr13954455ljj.167.1570377132016;
        Sun, 06 Oct 2019 08:52:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id p3sm2603640ljn.78.2019.10.06.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:52:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8EEF918063D; Sun,  6 Oct 2019 17:52:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Support injecting chain calls into BPF programs on load
In-Reply-To: <20191005203945.6b3845a9@cakuba.netronome.com>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1> <157020976144.1824887.10249946730258092768.stgit@alrua-x1> <20191004161715.2dc7cbd9@cakuba.hsd1.ca.comcast.net> <87d0fbo58l.fsf@toke.dk> <20191005203945.6b3845a9@cakuba.netronome.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 06 Oct 2019 17:52:09 +0200
Message-ID: <87v9t1na6u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

> On Sat, 05 Oct 2019 12:29:14 +0200, Toke Høiland-Jørgensen wrote:
>> >> +static int bpf_inject_chain_calls(struct bpf_verifier_env *env)
>> >> +{
>> >> +	struct bpf_prog *prog = env->prog;
>> >> +	struct bpf_insn *insn = prog->insnsi;
>> >> +	int i, cnt, delta = 0, ret = -ENOMEM;
>> >> +	const int insn_cnt = prog->len;
>> >> +	struct bpf_array *prog_array;
>> >> +	struct bpf_prog *new_prog;
>> >> +	size_t array_size;
>> >> +
>> >> +	struct bpf_insn call_next[] = {
>> >> +		BPF_LD_IMM64(BPF_REG_2, 0),
>> >> +		/* Save real return value for later */
>> >> +		BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
>> >> +		/* First try tail call with index ret+1 */
>> >> +		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),  
>> >
>> > Don't we need to check against the max here, and spectre-proofing
>> > here?  
>> 
>> No, I don't think so. This is just setting up the arguments for the
>> BPF_TAIL_CALL instruction below. The JIT will do its thing with that and
>> emit the range check and the retpoline stuff...
>
> Sorry, wrong CPU bug, I meant Meltdown :)
>
> https://elixir.bootlin.com/linux/v5.4-rc1/source/kernel/bpf/verifier.c#L9029

Ah, right. Well, it only adds those extra instructions if
bpf_map_ptr_unpriv() returns true. So I figured that since we're
injecting a pointer here that is not from a userspace map, it was not
needed. Though I must admit I didn't look too closely at exactly which
conditions would make bpf_map_ptr_unpriv() return true... :)

-Toke
