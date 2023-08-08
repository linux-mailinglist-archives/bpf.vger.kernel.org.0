Return-Path: <bpf+bounces-7263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A400B77460C
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 20:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC643281740
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3E154A2;
	Tue,  8 Aug 2023 18:51:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A413AFA
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 18:51:57 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65A22734
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 11:24:48 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-40849e69eb5so39532971cf.1
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 11:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691519087; x=1692123887;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeZ+lTBYLw0R6FU/F/eARhmKcEJ04alk4SdxU6Lwfnk=;
        b=TnkIzUGHbmuI/+KafL7MIOhkTaBeWRHatiaefIDmK+uAVtKfi8yrt7/NfP6iezztlp
         EkxrEMHm0rXEfUtCnYM6Owyp3KpOFkhPHEknXMmh9fPHrYkSLiU6V0GCsi/76jaKdaPv
         H8wtFLuiAZI5hZTrMGYICavvWwKB/SmoOxG0Twa98rb+eTBw3wLOGwvjQdwb8Ka7usyE
         Dkw9EP+QhRX5FK/v3aiXHYyHtO0piBkCuac5un12cjo1ccw4ZNorqlFjAur9j4i3ur/c
         McBqTI8KTm7OEFazoDB+ZRNchJzPOM4GnWnNbz0Kwa7f1BLPYFCSBygbNlTd3bOYUH1k
         Co8w==
X-Gm-Message-State: AOJu0YwDZ/70UbaT0mN7OyAvQyte0X+GxLR3BBZogYmZ46rEd/9R758d
	caZxW0Y1LmO/4E8LMYGvARROFsfWTpkjgQ==
X-Google-Smtp-Source: AGHT+IGPaDZGdg80zPBK3G1uLfR4TIVBiZ2v5VDq4HPtZLLrQlHI59zI70NBNk+rFoaCbD9733K3Zw==
X-Received: by 2002:ac8:7d45:0:b0:40f:df11:8bf0 with SMTP id h5-20020ac87d45000000b0040fdf118bf0mr747131qtb.14.1691519087287;
        Tue, 08 Aug 2023 11:24:47 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:b076])
        by smtp.gmail.com with ESMTPSA id cb7-20020a05622a1f8700b003f9c6a311e1sm3548577qtb.47.2023.08.08.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 11:24:46 -0700 (PDT)
Date: Tue, 8 Aug 2023 13:24:44 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH] bpf, docs: Fix small typo and define semantics of
 sign extension
Message-ID: <20230808182444.GA1158877@maniforge>
References: <20230808052736.182587-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808052736.182587-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 01:27:32AM -0400, Will Hawkins wrote:

Hi Will,

This looks great, thanks!

Acked-by: David Vernet <void@manifault.com>

> Add additional precision on the semantics of the sign extension
> operations in eBPF. In addition, fix a very minor typo.

Just for future reference so we can have consistent nomenclature:

s/eBPF/BPF

