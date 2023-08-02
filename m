Return-Path: <bpf+bounces-6655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03476C2D0
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACDA1C210DD
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B9A44;
	Wed,  2 Aug 2023 02:22:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295537E
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:22:16 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72845213E;
	Tue,  1 Aug 2023 19:22:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so87264351fa.2;
        Tue, 01 Aug 2023 19:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690942933; x=1691547733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg1SPaJl42hfjSIHYNQoMyEABB2W7molrKSYX8RQGy0=;
        b=fvNXVl0pgOdLnojeelwiYSfJHuu6BPC0eENGlj1xmr20XORUOkzxvTPNlD0lXcCeoe
         8DnDV91xWNIZKuTMjkBYiaaSj6OvcuudD1wxCeVPo50eDVJjDOVfWqlimmTxF4EwZBFn
         e9yDBi8yyi1jM3lHvXRFN2R4wPa20jSFbO5XR0oq5ulz4RtvFhPUPGCxv/0uhOjHddzV
         tEhXS0QXy5B0oOhExX15EKszy4txYxQuQs5BHI7s0y09auabnOW9+4vM3j8aZ+ZguSKk
         UnXnGtlBakb+gEXWYMYeUMI1EB0/EGPcCs2gNxAJTbsuYs0i64zsJK0d2lBaAlNTboob
         Wj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690942933; x=1691547733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg1SPaJl42hfjSIHYNQoMyEABB2W7molrKSYX8RQGy0=;
        b=iXrW+IZRrMQWh8z5SfdW3rlhUuSX/f9LNOZofLpleqbJ18t5hw9baqM298DtmSjL/Q
         Edn0FOvWDV8ePWwaCjw2oLzawgxXM7W/nZKZ26iNqzS4eEU70NV25zGVsfOY504305Ri
         fQKgFcncUlSaOvqcK2ugB+YldXONrP8fcxl4g5T0xM/tz1vsO5d9xU4EtmasJJaPhIml
         dk8ufvib7ANWXbyK/QQjxPFJKwKcF3rTJUvRJ702kteaMu2eVIoFkqiBMy3xELqvlHAX
         IJ/fq3gTE7rKhC59C6DhnPcqHufo2micPKAVlFr/Zq0FsjiJSvHsHvZe1vQ//KmD+d1D
         zkuQ==
X-Gm-Message-State: ABy/qLbmf4booIJFuM1IqEX71xxOZ0ztc+yBlcEbxtrfPI0hE8Khk3IV
	laeS2o3bXuUmTbl+FrMSUTqK7ovXOavLJ703+ko=
X-Google-Smtp-Source: APBJJlGoBvQLp+EM57aM03bT75dxdKy5hCV9qxCpnVKOhabfNLvU4n1NZ1cajNgcCMdejpRr9KSYVEToPM3UZfd8Dsw=
X-Received: by 2002:a2e:b604:0:b0:2b9:b6e7:bd7 with SMTP id
 r4-20020a2eb604000000b002b9b6e70bd7mr4069527ljn.29.1690942933052; Tue, 01 Aug
 2023 19:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
 <169078863449.173706.2322042687021909241.stgit@devnote2> <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
 <20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org> <CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
 <20230802000228.158f1bd605e497351611739e@kernel.org> <20230801112036.0d4ee60d@gandalf.local.home>
 <20230801113240.4e625020@gandalf.local.home> <CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
 <20230801190920.7a1abfd5@gandalf.local.home> <20230802092146.9bda5e49528e6988ab97899c@kernel.org>
 <20230801204054.3884688e@rorschach.local.home> <20230801204407.7b284b00@rorschach.local.home>
In-Reply-To: <20230801204407.7b284b00@rorschach.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:22:01 -0700
Message-ID: <CAADnVQLkVatr5BTScpuKaKAO+Cp=0KVxhqXwsjZoGhJPu3G4jA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Florent Revest <revest@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 5:44=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 1 Aug 2023 20:40:54 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Maybe we can add a ftrace_partial_regs(fregs) that returns a
> > partially filled pt_regs, and the caller that uses this obviously knows
> > its partial (as it's in the name). But this doesn't quite help out arm6=
4
> > because unlike x86, struct ftrace_regs does not contain an address
> > compatibility with pt_regs fields. It would need to do a copy.
> >
> >  ftrace_partial_regs(fregs, &regs) ?
>
> Well, both would be pointers so you wouldn't need the "&", but it was
> to stress that it would be copying one to the other.
>
>   void ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_reg=
s regs);

Copy works, but why did you pick a different layout?
Why not to use pt_regs ? if save of flags is slow, just skip that part
and whatever else that is slow. You don't even need to zero out
unsaved fields. Just ask the caller to zero out pt_regs before hand.
Most users have per-cpu pt_regs that is being reused.
So there will be one zero-out in the beginning and every partial
save of regs will be fast.
Then there won't be any need for copy-converter from ftrace_regs to pt_regs=
.
Maybe too much churn at this point. copy is fine.

