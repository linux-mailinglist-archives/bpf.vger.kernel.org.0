Return-Path: <bpf+bounces-11154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433E7B411F
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CA6062825DB
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98305156F1;
	Sat, 30 Sep 2023 14:48:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF26C2C9E
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 14:48:20 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A0BA
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 07:48:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so5455453f8f.3
        for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696085298; x=1696690098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiMfY3k0qZTMV622+opFR1LvgNsLeNjXguRm7yHHHa0=;
        b=Is9ajPx8GcPmH9zlj823prycELLLZcU3ZI6KbGBZKfITThUcJy0X8QtAvhKNin7wlu
         qYWqbqD5xu1/aaDTZzaKewkihC+r5Mc2hwrkd4gw+GCTd/yPC7gV+eeLmfHHo9chTJTC
         REelLOz501boH8lOTDy3ttR8Y6LI0ImXaXNjYUa5ssVhs20RXkZ33fKw2DmYSNi/4Kp0
         XfR4Qbpk3BR3JMr3EBNLPuuI7IyHoEsj2CIaNOyv+0mscE9OJK5OOnzto6Jnb7d4VqxX
         glN0WQMBMdR1mTdTXDhioSgAy+u84vEmzi57+rnqtbdJX5Rpf3lGJefjRQ9KyrgNI6/G
         BXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696085298; x=1696690098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiMfY3k0qZTMV622+opFR1LvgNsLeNjXguRm7yHHHa0=;
        b=W/SDrVnlVd1ea2VMABIJqKQl9plVSyNlbLIfCz6RZbgrXapGg9Lewi6whTrl28q3/+
         prdmQl4Q8WpexE5QRc4+GUr6Hvn5Axs7guVEhl2dKXR33ch6e58fUZ/ePoATxm+Vm9GD
         8pfn4rmlAyFH9VK8Km2cxk0SDitxMYtXdX5SS5BEDpPQJWP8FNKE6EJxCsf4mukov9P6
         3412bXfiX5L5+xELhAhG86Qd1oCa2EHuOj3DZc0Vlhr+lzZrBTBs1rcAeqfCvIOZWxu8
         EnPmX10iq/retGIx9bF8ENqf/8MDFNuWVBd6L+mGsh9/a5H1zVvh4DRWfUygVtfiezdc
         vkmQ==
X-Gm-Message-State: AOJu0YxsuaGhmocbMcsyOvsoqeHXVDOhwjM6+qRMHF1RyD7lzepZzfiZ
	0I3ipWvfwN5xhdS8+H9uu7vlVjvSx5PzBe6+xyZQTNkk
X-Google-Smtp-Source: AGHT+IHw8MwBsK3s0Ayyxw6uwAD+NqFjqpg/A5zLwEI389PUUBwPkWPCRTiZ9JEoNbuZVbNjCfkAAb9n5bO3CQJWUAo=
X-Received: by 2002:adf:e68a:0:b0:31f:db12:f5db with SMTP id
 r10-20020adfe68a000000b0031fdb12f5dbmr6164571wrm.32.1696085297664; Sat, 30
 Sep 2023 07:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com> <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB387814B98538D7D23A611E89A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 30 Sep 2023 07:48:06 -0700
Message-ID: <CAADnVQLg+p8uQ4JX16JAj8hMNji+OfManPymisO3c_o=ZseQdA@mail.gmail.com>
Subject: Re: [Bpf] Signed modulo operations
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 2:03=E2=80=AFPM Dave Thaler
<dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
>
> Perhaps text like the proposed snippet quoted in the exchange above shoul=
d be
> added around the new text that now appears in the doc, i.e. the ambiguous=
 text
> is currently:
> > For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
> > 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
> > is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and the=
n
> > interpreted as a 64-bit signed value.

That's what we have in the doc and it's a correct description.
Which part is ambiguous?

