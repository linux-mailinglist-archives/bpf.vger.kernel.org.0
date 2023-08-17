Return-Path: <bpf+bounces-7976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE277F298
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 10:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5642A281E2E
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9110940;
	Thu, 17 Aug 2023 08:58:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF506100A5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 08:58:13 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F83E7C
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-26b3f4d3372so2795615a91.3
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692262692; x=1692867492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehijAG3+DimElseOvhT2ydoS3VjVdNFUrFCVSW8Tlxc=;
        b=hSxOPHq4BKOHG2rjMx+eCEaltK6EuVzY7bFcWGYSKFEM4Ma2nvNcu1knimN7RQYL5j
         V6ZILhSBJ4uRpu1Yex71+JSerksuhVkWPYksqQmCYT+6Ayogq/Lkm02Xf3/T44eLdmfg
         AYrAhWo3fORH8bOal2jmfPFbxW92+q9w3Gvtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692262692; x=1692867492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehijAG3+DimElseOvhT2ydoS3VjVdNFUrFCVSW8Tlxc=;
        b=Ek6UwLgcbL1wvAPNczl3hH6lthXTuHQ621RxxJAiO6avS62cNOC+j+PQFMmWP9+VwY
         YMMltljZap8SyLkkNFKGDMkczG3GgKadJT4CgHum072lvib3Q5XMSEow2o6a+7YU5WsH
         dwQtwhYP12HTaJLDAAiDwe9tpROOdPite3vS9ar9aR80h5rk8olxRQYsczaWnoE3cB4q
         Yf14QXpQujeDVOJrQmUM5WAng0F4NNrILKVQQKdGfI8Ei106DS9gWGT+HG/kdYs0qicS
         Som84R42ToGXl3l8OEttBODSDxeIB+SOyB7lhIMOf/IR4hoB76aCHqru22U1PrYDEbHs
         hM2w==
X-Gm-Message-State: AOJu0YzmNuhOaUwNPnk/EH+1MMhZWbszB6emErqg9WcB1jhpX0HX6mgN
	KNSERIBCbczHkbDnm/61MG7culVH8vku9o3gxUwdJA==
X-Google-Smtp-Source: AGHT+IH7wJlK1Wn93MuV/91kwcNihtgsOunIPXO95uzJnJCqLl1ks9/sg/b2XhIGI7m4uJxhwSFPfPgEM1o0qlVcsn8=
X-Received: by 2002:a17:90b:3b49:b0:268:1be1:745a with SMTP id
 ot9-20020a17090b3b4900b002681be1745amr3423253pjb.29.1692262692654; Thu, 17
 Aug 2023 01:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169181859570.505132.10136520092011157898.stgit@devnote2> <169181869006.505132.4695602314698748304.stgit@devnote2>
In-Reply-To: <169181869006.505132.4695602314698748304.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Thu, 17 Aug 2023 10:58:01 +0200
Message-ID: <CABRcYmLzPRZERpF2PUru7_LJOASrGp9Q=ftdxFfJYCVd0QFDJg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] Documentations: probes: Update fprobe document to
 use ftrace_regs
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 12, 2023 at 7:38=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Update fprobe document so that the entry/exit handler uses ftrace_regs
> instead of pt_regs.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Florent Revest <revest@chromium.org>

