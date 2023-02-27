Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910176A421C
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 13:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjB0M6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 07:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB0M6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 07:58:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF66599
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:58:38 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so25331785edz.10
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URH5NS//qipivGswnE/LxUmWNVhVHzRkKx5ie6a+V2I=;
        b=J/3/wJwtPjLaxpQtm0jFxq4xp/ogJ8PU8HuSa6g89bVSehyYk/u3vJdScjLHevvGUm
         0dZXl4GM/JkhJXgApnZh18QDwxTVBbXanEj7lOx9plLrRKa+RuS5Eu796AEPuiyje1yp
         b36YHGpVgtiLJhxTBC8muOkiijBS0k7IYRD+/FOJ96f8jjohJZiQ8OUHBFWj/gSeNaMW
         iSyww2m08HzfrW3JPGnjDi1kIaQD3uRqdyIZmoy4vquE3QiNqjQuH3skChMEKQk2hvLJ
         jgNBThtCURZg/FHF11GMLnVNu+CTjDLF0mfm1EctZMGvb/bTiRsTTJrvuoVzjf1UKLfJ
         yYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URH5NS//qipivGswnE/LxUmWNVhVHzRkKx5ie6a+V2I=;
        b=yoTpkVdSHKZCxB1SzQOeZ3WlgYJzc6qYuitKPYCVzzx/99pCQjpasXJxXkXvGiZS2G
         HZRQnmxPU47Rl7hbj5oZykkuDEsWrsv1nGO6IlmyYSl9xMUIM/gB3wiZCJzbD+TM8Y6n
         14x2uZ9pgLveXlwnjHtCly167z/deUSMdvJDLA4CyrP1CqJlELs5CFm5chL/nbZ5REZi
         y7eh09f1/ttej2xy7/g9wtEXCKUl4qUCd/438rzAscTkqlkuyLxRTO1QPpoXcN1a3dBM
         O5deAIgO0nRBDq2q9JuCT2cNwiQ/Th7G08W5Vt1DUQAmtm+6UxtUK+68If767FMSs8oY
         haAA==
X-Gm-Message-State: AO0yUKVSF6WFBVWkekr/j2kSCzI3V3s6HA7+od1omCnCeldjA6D7wHiT
        7WqU8WlKp62hdKuVMykkfCg=
X-Google-Smtp-Source: AK7set+IgKFtsJBmrl/X00DtJQbyOzHlR/f08ffvd2KwlRydtSGdjkbTEyzsXzCjdblcHPx0BbYg8g==
X-Received: by 2002:a17:907:98bc:b0:8b1:7b10:61d5 with SMTP id ju28-20020a17090798bc00b008b17b1061d5mr34911132ejc.33.1677502716500;
        Mon, 27 Feb 2023 04:58:36 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fg1-20020a1709069c4100b008c979c74732sm3208125ejc.156.2023.02.27.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:58:35 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 27 Feb 2023 13:58:31 +0100
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v8 2/2] bpf/selftests: Test fentry attachment to
 shadowed functions
Message-ID: <Y/yo9xfP9xMKGH6H@krava>
References: <cover.1677075137.git.vmalik@redhat.com>
 <b66118d393edf071e8acdbfcb22965985192f00b.1677075137.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b66118d393edf071e8acdbfcb22965985192f00b.1677075137.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 03:35:29PM +0100, Viktor Malik wrote:

SNIP

> +	for (i = 0; i < 2; i++) {
> +		load_opts.attach_btf_id = btf_id[i];
> +		load_opts.attach_btf_obj_fd = btf_fd[i];
> +		prog_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
> +					   trace_program,
> +					   sizeof(trace_program) / sizeof(struct bpf_insn),
> +					   &load_opts);
> +		if (!ASSERT_GE(prog_fd[i], 0, "bpf_prog_load"))
> +			goto out;
> +
> +		/* If the verifier incorrectly resolves addresses of the
> +		 * shadowed functions and uses the same address for both the
> +		 * vmlinux and the bpf_testmod functions, this will fail on
> +		 * attempting to create two trampolines for the same address,
> +		 * which is forbidden.
> +		 */
> +		link_fd[i] = bpf_link_create(prog_fd[i], 0, BPF_TRACE_FENTRY, NULL);
> +		if (!ASSERT_GE(link_fd[i], 0, "bpf_link_create"))
> +			goto out;
> +	}
> +
> +	err = bpf_prog_test_run_opts(prog_fd[0], NULL);
> +	ASSERT_OK(err, "running test");
> +
> +out:
> +	btf__free(vmlinux_btf);
> +	btf__free(mod_btf);
> +	for (i = 0; i < 2; i++) {
> +		if (btf_fd[i])
> +			close(btf_fd[i]);
> +		if (prog_fd[i])
> +			close(prog_fd[i]);

should we check prog_fd[i] > 0 ? same below

jirka

> +		if (link_fd[i])
> +			close(link_fd[i]);
> +	}
> +}
> -- 
> 2.39.1
> 
