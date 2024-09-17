Return-Path: <bpf+bounces-40041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A897AFFF
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 14:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03841C2085C
	for <lists+bpf@lfdr.de>; Tue, 17 Sep 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5C16A959;
	Tue, 17 Sep 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSmUyipB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA31B85F2
	for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575253; cv=none; b=sgmCIMfBE/H4a/9YgGqlDsPf0hlff7HA5kOCeOoPnSbOlkfOOmrk1jxcQAHTNJ6KcsSgHJj5f3xcek/Wx2iwAXMwocCTel966KPTfiqP8x4X/83RDy6QSjFMohFXTDOW3lL6jGzEw2xxJyfqzK+XvR5MgqDxYeBnJ+dNSxEFMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575253; c=relaxed/simple;
	bh=dNOyc6yx3NH63mp4ylHB1CXRSC1Yw4nnqKxpT7UdOEw=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=VPjMNdh5ZB8vsbxguxeTDTd27Gp0nIxiBgByT0ZMoCQ8DOMeyee4GJ8N1GnPn3BO4jNVoMoKWasztSGi4RB/V7+RqhqAmLakSz2Kh9rU80v9EJ+UtGvvqN2Wy2vcE2ME57NJ78gkG4IBfTVa1U0m2JLsrm6duWrelhvV9QZn1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSmUyipB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7179069d029so3424520b3a.2
        for <bpf@vger.kernel.org>; Tue, 17 Sep 2024 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726575251; x=1727180051; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxitZxgmvoGPY/D0MWsatY/SG1INnyxTi18mvHYSZYE=;
        b=hSmUyipBxbWbpmC71rXxtJuhakmeXys6HT4ZTf6LBMw69pTwRtsKyQv46RyCJ4ieEf
         WNm6qTzT6cyRIHkCPFNG2oW24czFWTkNohRsTXPIBIYy8kjm8y0nxRj8eBaXnHPfI/XG
         IKWTDGMTt69bdAFubcVAUarCj+dEFooMq5UX2H5xL0tfxVTmBdxThhnFFATLXWGZ0t5r
         iiWufK1kgrj6Ynpt0fW6j+N2RrOcecoM4ybkSV7WS4ERymIP+lmjUOFJeizuekqQnOay
         0Cl5jUwZeUIcsKhIoAcxlLEIQDKdhkDqxcpFmobWcDQb0qE30TArIHwxxSdBlaADbmZG
         emJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726575251; x=1727180051;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxitZxgmvoGPY/D0MWsatY/SG1INnyxTi18mvHYSZYE=;
        b=P4gonDz1ftkd9URuCjkPZ+qbpVCk678iTsMtYUwO7c/eEYtkf4hAITyrYu8LhC4ajK
         U9n9VVGnO+1hwTiz8+i6+nqBMrtTyC2TpUysDq+Chvo9G7T7HEdwQ6RAl1C6g6D9678m
         iBjwdLBzvLDjq+laz09/i8WMTVPMyhplPtDcxrskkPe5Js1Xx+sx/eu2krHK7x2WRKgV
         0z9uGjmFtFDVS3gnoliGSeuVnYoVKc95iZppp1001WR0Nbt1dJ+tSlAvbY6g2CvUyMMK
         yQMHS5hptkRAfcCilw44+JsCy7NSQp5cTeAjHp46U/PEn/eF1csr1cVbePYjZAFlvfhh
         1ulQ==
X-Gm-Message-State: AOJu0Ywn7ZcKjchjD/JT/so93sksvheXG5WxqI2oso9QJ6+Iv/R9GCcJ
	aN200pYONgOPf2wVAyxMp7leD5cNWilw6GKhpuKlNgxlWKBHBlbC1yCeRg==
X-Google-Smtp-Source: AGHT+IEtG260HtJmVa6k39GdL3OJlw7wyAciUIRlN1Ol++yaCK+AJEIo9jdj56McTjTikrYCPe6HGA==
X-Received: by 2002:a05:6a20:c99a:b0:1cc:e47f:1004 with SMTP id adf61e73a8af0-1d112db38c5mr19365808637.26.1726575251143;
        Tue, 17 Sep 2024 05:14:11 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc29d7sm5059715b3a.187.2024.09.17.05.14.10
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2024 05:14:10 -0700 (PDT)
From: Michelle Fangman <ggughu6237@gmail.com>
X-Google-Original-From: Michelle Fangman <michfangman@outlook.com>
Message-ID: <d892c98072d15727bfde992ddaf8f988e5d3aeb7d53ae79499845ef3896abadd@mx.google.com>
Reply-To: michfangman@outlook.com
To: bpf@vger.kernel.org
Subject: Grand Piano 9/17
Date: Tue, 17 Sep 2024 08:14:06 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm offering my late husband's Yamaha Piano to any music enthusiast who may appreciate it. If you or someone you know might be interested in receiving this instrument for free, please feel free to reach out to me.

Warm regards,
Michelle 

