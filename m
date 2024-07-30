Return-Path: <bpf+bounces-36080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E3942138
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 22:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727A11C23E6F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0B18CC17;
	Tue, 30 Jul 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HYfr7WYN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E418B470
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369741; cv=none; b=Jjm/0Kltzw/KXwEsAG7jD/UqBhWrQSb+Sb21YPETloJuWJIhUsiYToTimKP5od0BAv1Vfw2XlW09PdbLiokQ+FEkvcqlf38PkNPGKp/00hcNkrn+xV2KsQkCfcCigPpfjtod7uVFf574+oMhfV+rM2lZvftOvbj0ullUp6VMj30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369741; c=relaxed/simple;
	bh=g3+niUA0xpO8QTVJVcFoGPOfgBAUBJotciNokbhnVRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWqLqLYuGdjgFiVw0olemt2uF7us4p44nS7WQPAVLcVPLHBKAoJ/DC/FGqE1cmV7lX2S0hxqs5MZ3wn9pJZ7eAK4QjOjzb9JzDHPeErGcCJgyJMN37eELMY9skbT+I/q5FfPzAMtAZaaLjlccoCFEd3UISJEaD9jfSNz8G9X6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HYfr7WYN; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0885b4f1d5so3574013276.1
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722369739; x=1722974539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2gM+dZs0nyyuKls7rKhwHwLihUP2+Vq1HQ7Y/s6r/BU=;
        b=HYfr7WYNGarWyLNF69C3lXcrXW/5WVaA+PPajlEQ0z7AieDIHFfyOwQO/a7k8Fkofh
         rso4vj3PmFroT1anQVjb4V7pm09jvAv0JMJwo5DcxD8nPYDe2gmu0eaTXLJqzTUDkaxj
         voWPaWN3QVYgGAM7jG3XAkcFtnvSxBocGSwZnC/9h1a8cdyt73QRareaVtEG9jXk5/y/
         IcUBny7mNWZb4oLjnriCRSBwJvEfU5PJN67SFqyTdLgKBELgdmXdtLLe8MfInSQIRUH+
         +7TVrEwPVVscO6OA0cd595IFLAY9ov5bc8Oqi/p+UlEAg5z1gYuJRbShFrkm9XQxKpLg
         YAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369739; x=1722974539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gM+dZs0nyyuKls7rKhwHwLihUP2+Vq1HQ7Y/s6r/BU=;
        b=MYBylN0jYZ31OGrC3OZ5fWXeUDy0e1sH3ogyFECxecl2tgcAncuhNWte69/P7Z/I8q
         8PtReiG0+tUAjbhruhaXAiXTEOqt/shaXp8xVWxjhFZ/c8nOVjhRMdri9y65ltZmQ5lk
         op4xqUU41YMK2etapFbPq55JrjgxjSg0NTL9Jb2Iu9spVOucClqf87AznKyWOOjWtm3i
         +msWrK+j1C8FsmO/mKzHvucJmoTamUTuJtKGLTfBAHYXazJc8cqscI3EcMJs20lRZgww
         McxS0Z2G931EeqjISv7/k5xIDimTVkXO5XZSyZFJhpCPXLRo4eUtT6LR4xjSZIPL5iJ1
         Z6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXdAJnG8GQzJTzcnCSWQPcAAfSs47OEJfw8hNJBBVGw3MMeRgX4C3Hs2cTpHb345nN3yinGyIFQVa7GhekPGszxDi/5
X-Gm-Message-State: AOJu0Ywuin34/aPbbIYp0jJcni4wbhaO2OVELhtILKCAaNUq3+xARRoe
	GcT0Qw3FASP4S/0Sqm5cUafGr9K58lOO/4QMMUwjC9/QHpntwoVsMORmsN9Qrsg=
X-Google-Smtp-Source: AGHT+IHLhGc5P0Jkbn9GYe5+/TwFVFrZFTBX39bypM6SoAI4XaUY0Lf3nB+cU1gq/JuQtI04+biYKQ==
X-Received: by 2002:a25:d6c7:0:b0:e0b:28fa:75da with SMTP id 3f1490d57ef6-e0b54402a04mr11264617276.1.1722369739201;
        Tue, 30 Jul 2024 13:02:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b2a93fa51sm2532245276.54.2024.07.30.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 13:02:18 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:02:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCHSET][RFC] struct fd and memory safety
Message-ID: <20240730200218.GC3830393@perftesting>
References: <20240730050927.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730050927.GC5334@ZenIV>

On Tue, Jul 30, 2024 at 06:09:27AM +0100, Al Viro wrote:
> 		Background
> 		==========
> 

<snip>

I reviewed the best I could, validated all the error paths, checked the
resulting code.  There's a few places where you've left // style comments that I
assume you'll clean up before you are done.  I had two questions, one about
formatting and one about a changelog.  I don't think either of those are going
to affect my review if you change them, so you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series.  Thanks,

Josef

