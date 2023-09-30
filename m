Return-Path: <bpf+bounces-11158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C71E7B41BC
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0417B28360B
	for <lists+bpf@lfdr.de>; Sat, 30 Sep 2023 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A2125DA;
	Sat, 30 Sep 2023 15:36:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB78F52
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 15:36:53 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E9BE
	for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:36:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3226b8de467so13076452f8f.3
        for <bpf@vger.kernel.org>; Sat, 30 Sep 2023 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696088210; x=1696693010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQV529HwlabxIKy7J/5tNCMJbN7Wd97B8SSJdVQQjg8=;
        b=Fmcr2FQYbxSapJMHmqS3+AUqa0ixUYa5rFm5sZgyVklApX/DetFYlAm8q58Z9fZGrp
         BaBbjhWXWjDx/sMsv+XGERqomYSBzz+z+rfXU9RsReyQXtCM4UnI+EH/jI+DgfmSJq0o
         LHfwCO0MzEJrkfAnhQSwDTS45dWfup8QndgBEh2gL1BbLeiGzTbxWec1q9mJGhOIkj01
         7xTvY8BzLiWw2izRnAYmQlaulpZGXxoNF9UebROeaB42tldsVqlRPUm9X3qKon3E/UDI
         NXee54yL0gi/0gnAms/kIUQoZpTfbuNsH/NFqFhzk9i4bSsmf8bR9MfGKS9Z2cbnHzG2
         F36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696088210; x=1696693010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQV529HwlabxIKy7J/5tNCMJbN7Wd97B8SSJdVQQjg8=;
        b=pE1FDW6XgHYWyCnKqa4VCXi0cZp/x1v6Wwx0XwSSiSxZ7i0MAEf2S9HtTGl9h/Z151
         RBskcEYmpnLPJlTpJ8Ly0Gl3ZNqCp5DLObtWi5b/5HasuMZIJy0BONHwUYmulZHbvOWo
         LnHOqT3GlXHhulhhNUv3Hl/In3wafGT7Yq+muoyAijRVVV8HSzgpjGk73kpTqTYz+jVo
         6hS47o6TqPoyqYUkDEfx2gWBgNElU8aEbnG4HfT1vGLx4KLNcb/SbZI2crdwT3OcFZ/y
         TNxDI79U6OQVGZGTVyH8g/XBo1Lh2MhET57NQgAe13eEvM1En/R0jbAEsOzM24Ei1U/7
         fSsg==
X-Gm-Message-State: AOJu0YwN2ejIKIy7RDmcrE/z6VucgEWx5XaoodbV7i0tPbYOrWfYIE8L
	wBoJhlYYv44O6JKMOGDy5PcPeE5dKDuuQqmx5c8=
X-Google-Smtp-Source: AGHT+IGNrnRSxK8he5p8yMrAAPyEzQQFoPVuifatRCCYAMEEDVUNd+EOc4H0fA9nMCo7bxMykFJ+d6lTjjgIAgh5CEo=
X-Received: by 2002:a05:6000:10c4:b0:31a:e6c2:770d with SMTP id
 b4-20020a05600010c400b0031ae6c2770dmr5858915wrx.36.1696088210257; Sat, 30 Sep
 2023 08:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <169566875696.34978.17222195480011841703@ietfa.amsl.com> <PH7PR21MB3878C2BD3D1BBF7EAE077A03A3FCA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878C2BD3D1BBF7EAE077A03A3FCA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 30 Sep 2023 08:36:39 -0700
Message-ID: <CAADnVQK17vHEL-bjxpBhPTx+PAY8m15w-74DTNrj-01wjo8W=Q@mail.gmail.com>
Subject: Re: [Bpf] New Version Notification for draft-thaler-bpf-isa-02.txt
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

On Mon, Sep 25, 2023 at 2:57=E2=80=AFPM Dave Thaler
<dthaler=3D40microsoft.com@dmarc.ietf.org> wrote:
>
> draft-thaler-bpf-isa-02.txt is now posted in the Linux kernel repository:
> https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/

"Initial values for the BPF Instruction registry are given below."

has bad formatting towards the end of the table around 'lock' ops.

