Return-Path: <bpf+bounces-6381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916A7685D4
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008652815E4
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1C3D75;
	Sun, 30 Jul 2023 13:49:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA8363;
	Sun, 30 Jul 2023 13:49:27 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6BC10C1;
	Sun, 30 Jul 2023 06:49:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403b36a4226so16579761cf.0;
        Sun, 30 Jul 2023 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690724964; x=1691329764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlliIXo6uvrh08ojtOL3l75jp+3FAUoZdbrhJ9gY36E=;
        b=qEe/zN7auL/09nK5d8mKb1+/OjEMFoMxKz8xc6T/ntSdzi8G+npmr55x3t1SxgXuMx
         +VukRHmefryMS0onazV7SximRLqYA8oa8Rj0dUlD3Z6no2jvnsOc6lF4Cxb2i8up01S1
         etk9hJvHq+hOKAlQgVk0Adox4LTETi171kcFiy6IB1l1qZzMrE9dYjIS2uv+TsF4WTcq
         V+m4NPnuWIg/5OxtWLX5uSQ0qsmtvGx5Xjj+/V74cPcLDhWYEqxDv2RgkO4M6qJPipgw
         3zhqkU8eUtO3Phz2it6QzkiunhjTnxtBKH8SWZRSEsLAEoTZs4SK9MC5zN2KOqBkuZZv
         9eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690724964; x=1691329764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlliIXo6uvrh08ojtOL3l75jp+3FAUoZdbrhJ9gY36E=;
        b=ijkFFWXswG9d5CBxtKTvNIyGrFJnKATxwpHzdd1+rmRjJ1YXVFx0oXv9JKhj+pjgIf
         raLISYXt3hn+Tv6rWSaTi1BxVT266qNe/cErqmOgjV02Zr8V1SQ80wFhCtB8dZFGZKag
         iFpbn2tnmaiqzeD8UYnQUA24FIo/JSC3RsvlYkdnAk7MtanqAuG/8dGL99qkTYlCo6bu
         TtGth35OoeH6Lx7NSUjvHtNJpCt2vElvTi9aLjw+NDr9lPsa7N+/5OcXUiBZcbgZ4/2m
         siAtMfrS8Qv+FffB5hd3I1Ma/d4QqCrjM6Yo1Lr4Ao8qcTerQMwIFGy8egc2Ve74ALaZ
         892w==
X-Gm-Message-State: ABy/qLZiReVMVA+0Ml9JfuLr04T5Ur8/zdQggn0Hesoz5lyFozDUUqxZ
	l05Oc3JlkzBP8mBocq1LkwyeXQQJvuaE+6B9oiIMHjJZEc+Pbyg9
X-Google-Smtp-Source: APBJJlE8m37sRUm45VC3Dw3ekTbcowEPlAHwCfE8/e5sWDKU9fPzGQnSEePTwCLFkzQcghx6XQHPt+51Ako5OsdBuy8=
X-Received: by 2002:a05:622a:1212:b0:403:c2dc:929d with SMTP id
 y18-20020a05622a121200b00403c2dc929dmr7268810qtx.48.1690724964385; Sun, 30
 Jul 2023 06:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
In-Reply-To: <20230730114951.74067-1-hffilwlqm@gmail.com>
From: Manjusaka <lizheao940510@gmail.com>
Date: Sun, 30 Jul 2023 21:49:13 +0800
Message-ID: <CAFYRFEw98BhpcLyFdwivLcy5M6hk3fDRcWZVtUytSw7kNUQXRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] bpf, xdp: Add tracepoint to xdp attaching failure
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org, tangyeechou@gmail.com, 
	kernel-patches-bot@fb.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch is very important to help us to debug the xdp program. At
the same time, we can make some monitoring tools to observe the kernel
status by using this trace event

=E6=9D=8E=E8=80=85=E7=92=88 & Zheaoli

Email: lizheao940510@gmail.com
Github: https://github.com/Zheaoli


Leon Hwang <hffilwlqm@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8830=E6=97=
=A5=E5=91=A8=E6=97=A5 19:50=E5=86=99=E9=81=93=EF=BC=9A
>
> This series introduces a new tracepoint in bpf_xdp_link_attach(). By
> this tracepoint, error message will be captured when error happens in
> dev_xdp_attach(), e.g. invalid attaching flags.
>
> v3 -> v4:
> * Fix selftest-crashed issue.
>
> Leon Hwang (2):
>   bpf, xdp: Add tracepoint to xdp attaching failure
>   selftests/bpf: Add testcase for xdp attaching failure tracepoint
>
>  include/trace/events/xdp.h                    | 17 +++++
>  net/core/dev.c                                |  5 +-
>  .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
>  .../bpf/progs/test_xdp_attach_fail.c          | 54 +++++++++++++++
>  4 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fai=
l.c
>
>
> base-commit: a33d978500acd8fb67efac9773ba0a8502c1ff06
> --
> 2.41.0
>
>

