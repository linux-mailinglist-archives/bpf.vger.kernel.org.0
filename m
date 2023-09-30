Return-Path: <bpf+bounces-11160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37077B41D9
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 92ED32836B7
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515C17723;
	Sat, 30 Sep 2023 15:48:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D5125A2
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 15:48:32 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2618F
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:48:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32799639a2aso133949f8f.3
        for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696088910; x=1696693710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK5+3t0RJRwjjtBlkND07xhScJ0eD36iRg6LirUJ+Cc=;
        b=bMjdMZ75rrFAnIsmk4TdQmusS6Lw07+5MzuWtDxqQDGeXJx2viBeX8UQfCsKa3H6Bp
         qAWqrC3Hu0m4MlLePsTgHGr+QyDVzTopxbsVSlvVkg79GVGFajx+u45qV6MVfu3DIaCd
         UJicMdVuc0+E/FAWQOrZVUVwUCQlz0DA0pNP7xEyVwOYd+l99JAWYi5YfeErfirXNLUz
         E09UEfHi7V5lYUt6prRZ21biqMEzRDa8zRXHjpta8kLGvcxD4Sci3ny+bQDGgCZpQwr9
         1Y/oz3fiGEOdiAeGJET56hkGlYLUdiqJbRLD7NuWTitj6E8StiizM3jqIsmytC+6kmPe
         R+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696088910; x=1696693710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PK5+3t0RJRwjjtBlkND07xhScJ0eD36iRg6LirUJ+Cc=;
        b=V4/U89cWvaFz3IAXlXwNKjyJrjCPj16A7BgdH67WQkTA4xi9tZhdW9sD5iSVDD0LgA
         dnD0bMspGJ6u/6puBcn/y/6etKpH0tozlWkPA8LTgjLZgmkEvXo3Loh3glB905KEhX+9
         IhVBqum0m3ieILwcETbZrQdBA0HiEGPF15NuwdVSu0Htlxr9A7yT0Z2RvN2ZzQQY6Yq9
         a4hcu6MhgcPYdqe7DPYVOM+jXz2wp0iO5R4ZJWH0a8Ik11Jk/RhqQSbA2ZEr2JW0Daw9
         u5EDJhgETLZehHXYOnSZIcVeMEtgYjdAXOtynllEOqEZmoNwH3jZccpqTBKiPqjkF+y0
         vWcA==
X-Gm-Message-State: AOJu0YyTxzVx/TM4CDeasq3fFKz1XfG3Gh9t8bIxdRUzlV6nZdpew4H6
	RjRpaHIVutMOk3wMPCffJa5BJDoTdZKg4/szJ67Jb9p0
X-Google-Smtp-Source: AGHT+IFXz0a0gbubac84HUCwyzjkFoZsnivdfYxrZcn8Hzjwf2OiudFzZwI+KA8ooQP4PRAIycnwavw4OvQV6NFNzPU=
X-Received: by 2002:adf:e583:0:b0:317:3f70:9dc4 with SMTP id
 l3-20020adfe583000000b003173f709dc4mr6237808wrm.31.1696088909660; Sat, 30 Sep
 2023 08:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 30 Sep 2023 08:48:18 -0700
Message-ID: <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
Subject: Re: [Bpf] ISA RFC compliance question
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 1:17=E2=80=AFPM Dave Thaler
<dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
>
> [fixing weird character issue in email below that caused a bounce]
>
> Now that we have some new "v4" instructions, it seems a good time to ask =
about
> what it means to support (or comply with) the ISA RFC once published.  Do=
es
> it mean that a verifier/disassembler/JIT compiler/etc. MUST support *all*=
 the
> non-deprecated instructions in the document?   That is any runtime or too=
l that
> doesn't support the new instructions is considered non-compliant with the=
 BPF ISA?

In the linux kernel not all JITs support all instructions.
That was the case even before v4 additions.
Same goes for various user space tools.

> Or should we create some things that are SHOULDs, or finer grained units =
of
> compliance so as to not declare existing deployments non-compliant?

I suspect 'non-compliance' label will cause an unnecessary backlash,
so I would go with SHOULD wording.

> Previously we only talked about cases where instructions were added in an
> extension RFC which would naturally provide a separate RFC to conform to.
> But I don't think we discussed things like new instructions in the main s=
pec like
> we have now.
>
> Dave
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

