Return-Path: <bpf+bounces-8644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1DA788D02
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186C71C20CC5
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E04717732;
	Fri, 25 Aug 2023 16:12:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593062571
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:12:42 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3571BD2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26f3975ddd4so704913a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692979961; x=1693584761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3K9GAzZPmrf69JfCVKUGLeyRxUQaU+/aTKM9BOzOE0=;
        b=cYNfp9vLbjf8tVTE47Bc7cP/0E/Xwx0j7tnAYEARoRhzTwEYc0ufZryAlt1ur8TmII
         MLZkGn1N1dyP1dYJnuTjfLonzEgoEb0Yu+hTIQKnPlffIeyqIJhvG28i7kXPC5u0Ajcb
         FLgj2CoL7k6bdFRKEGMADSGtdhTVmTo4OahsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692979961; x=1693584761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3K9GAzZPmrf69JfCVKUGLeyRxUQaU+/aTKM9BOzOE0=;
        b=ZwA7ceeWoB4584cAjNZ2fQyEYjr1/Y2RcZ5C7wQwN60JlQD3Bb1NS6ZlXASFAzBPf7
         OcQyqjutM5OY/x8TxtBkdPo0MDf9xJLVx1Oa1Ot6m1oL6VLwabdtytNQ6X9RI8qMIZYR
         Ue9VlAR4gmC0WBgJ5gQnC27HSu9L2smg0s1ZMgSYreGeR6a63lgvfYOtdBLl825d0BhK
         KOjgeOzJ4VRHOLYPcYflMwr1zI+whE2QGWoZxF1MSu82YPkqaFpODzRb1TNCaJdCxzvm
         bAvSVu0SRccydmJ3t+CJZVebk8jNA8PvmhH53BmokLjHTwey9Hvvjrukx67HrIjdkSla
         nCig==
X-Gm-Message-State: AOJu0YxIwSoaMuP33pkcEC11WtioLdoHLqwlwEiTjDv2dnh5YsZpYWfk
	DzRJQmMDTbtFWW37/ATzCPtJVCdUPdJrKe4r5dHmsw==
X-Google-Smtp-Source: AGHT+IGVZOa2Il9SMW0TIYGfWLMiPG8S6YwqeylIfeo4abOQtStvAldvxSg6EWjVVD7VGXHSdNLWhT8f1dSEqXg4gbI=
X-Received: by 2002:a17:90b:1486:b0:268:1dd3:695e with SMTP id
 js6-20020a17090b148600b002681dd3695emr15524004pjb.49.1692979960981; Fri, 25
 Aug 2023 09:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169280372795.282662.9784422934484459769.stgit@devnote2> <169280382895.282662.14910495061790007288.stgit@devnote2>
In-Reply-To: <169280382895.282662.14910495061790007288.stgit@devnote2>
From: Florent Revest <revest@chromium.org>
Date: Fri, 25 Aug 2023 18:12:14 +0200
Message-ID: <CABRcYmJcii6UzJR+jksg9SMYAYZRNqEhKoHp=V2xiPYh76Q2vg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation: tracing: Add a note about argument
 and retval access
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 5:17=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fp=
robetrace.rst
> index 8e9bebcf0a2e..e35e6b18df40 100644
> --- a/Documentation/trace/fprobetrace.rst
> +++ b/Documentation/trace/fprobetrace.rst
> @@ -59,8 +59,12 @@ Synopsis of fprobe-events
>                    and bitfield are supported.
>
>    (\*1) This is available only when BTF is enabled.
> -  (\*2) only for the probe on function entry (offs =3D=3D 0).
> -  (\*3) only for return probe.
> +  (\*2) only for the probe on function entry (offs =3D=3D 0). Note, this=
 argument access
> +        is best effort, because depending on the argument type, it may b=
e passed on
> +        the stack. But this only support the arguments via registers.

supports*

Otherwise:
Acked-by: Florent Revest <revest@chromium.org>

