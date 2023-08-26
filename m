Return-Path: <bpf+bounces-8754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE02789872
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29B71C20950
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82375100A4;
	Sat, 26 Aug 2023 17:39:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC02C9C
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 17:39:37 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD710A
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:39:33 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d74a012e613so2718094276.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693071573; x=1693676373;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoVLQm1UJdsQtNNpzj835FQjSyWC6l8TRBCUApOxE4U=;
        b=TViY4P+FlPiCqbtK2TUsd3UOgE/9qnrYaP8/8jH+0PRiNfMtv5kQxuJnVeP0KGyocc
         k00oun7Og/s4Wi45hZnjXRcEZkXwnxq0SmiF+1XshJfmH8U13/ctzHMds6wCC7O+kgXr
         HlM8msj+bIHSI+xzVw1HP9hbzeBwr7PaDgSTq0yGmoJrEHrjMFD52eMeb+HuHy3FAb4k
         cESDmFVJeoYwq8axE84wO7KuDKeQxU/vieOsQ/YSuckkb8I5CK0drawgNEaddjr2Z2wm
         4qHlKTFyTJaGWKIAyU966dXmdt34BsK44HvDyq+19e/yMdoXgW6Zs2JF5vavEB9U/QFS
         aAtg==
X-Gm-Message-State: AOJu0YxQfZRfxdi7zmSb+qOzicYSVO2mgofVVOu9YhFCRoHEiKFKLPEa
	XoM5VV7TdNuT2N/8kq43hwJy7fcCdQo=
X-Google-Smtp-Source: AGHT+IGc/IVaa4zebs+5I9V0yixhkJ56QAQol/8vCJDD5uqQDBCtkAVl/RKMqkCA6cy7MpaD+9vQIg==
X-Received: by 2002:a25:d38e:0:b0:d4a:499d:a881 with SMTP id e136-20020a25d38e000000b00d4a499da881mr20660791ybf.9.1693071572961;
        Sat, 26 Aug 2023 10:39:32 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id a22-20020a25ae16000000b00d687cf69599sm917896ybj.52.2023.08.26.10.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:39:32 -0700 (PDT)
Date: Sat, 26 Aug 2023 12:39:30 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Subject: Re: [Bpf] [PATCH] bpf, docs: Correct source of offset for
 program-local call
Message-ID: <20230826173930.GB100673@maniforge>
References: <20230826053258.1860167-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826053258.1860167-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 01:32:54AM -0400, Will Hawkins wrote:
> The offset to use when calculating the target of a program-local call is
> in the instruction's imm field, not its offset field.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

LGTM, thanks for the fix.

Acked-by: David Vernet <void@manifault.com>

