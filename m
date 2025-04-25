Return-Path: <bpf+bounces-56676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF435A9BF9A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EDC1899F88
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ECD22F14D;
	Fri, 25 Apr 2025 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpeneKFk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F51B3930
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565409; cv=none; b=U36z2Xg0EJTqybW+sKt/4Ni387TwyVLFHr0q1f/FcQZTmnNjNfWL0AdeWUmmlvRmH7ARfK4JAj0TkkatjmTHO+tgGAysClnqaBHmXV+N2M8C9bldgVa31x0ZcQMappO7hnOgpWjYQ7H8JHkgUYvglIi65MtRzf4HXnLMDeVwZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565409; c=relaxed/simple;
	bh=ASQO1XiUSHtD0svFdr160Zr6VBnwK4XiC0Djrrm3Ow0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlS1s6pud4FfJfUrckoSAc0YBzVMCV1CTCEWsWvgffddRJZIuUA3LgJ35MZJFfOQ45rAveNNPyR0rn8Dbpi9F60EQKGXIo/izgWSQdBizGanP3rU6f/AADIJ2daMF0dPdgxZJKg46tFJgkIJYaHLez8IlItOSmKShedyJDWJhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpeneKFk; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-acb615228a4so518890266b.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565403; x=1746170203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ASQO1XiUSHtD0svFdr160Zr6VBnwK4XiC0Djrrm3Ow0=;
        b=BpeneKFkiEfkG/BerpWR/9D/jeVT0xaaRmoi3N0OWxd2fhBw8F9A7KCebIZIq5YOvD
         U2tFaI9Ynbbw8X9Uf2gItMiixWSzZ8m5p64p9+FpWwEpmlhR0WH+DX0j9pawozbYu3Oo
         +XxI/zmm1op2ORrNRgmL2lLf8z12xknO2c0pY/dM8ECdGfttv3+KIPHSjDZFbhR8GkYA
         TBGGz8wl8ksXOJlNuhlJpWcii3CtkIR2ylCsF/5zq8d1/9BDGjDWzgzSwTLoGJEKbxSD
         zSknKoiUwFIwpjf1c1DtxVDS/vDtTFodpvPsDAiDfMCW6VtwbCUcKwjX9NzR5u9fZbuU
         78BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565403; x=1746170203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASQO1XiUSHtD0svFdr160Zr6VBnwK4XiC0Djrrm3Ow0=;
        b=NsQjwNPHtKWG2ODNWJ+OA8oDoNA2InM3v72ZX0A4KSJFaSlc8pO1+ddx/fD4Kz3ieh
         pmIlB5rgnJvSzgfrttE+wwcpAecNxVvc9THEc0mh4JJ8vXU8riCl8WvpF2YGivY+rEOS
         mza8JfDiu29IqZMkXIu+vslWrSz/33bhXW/fRuGvmrLDngawMrj8iQyvEq9OqkdhsQFn
         lK+Yk5qt3YgfSzmLH86QPDFOFCgirnOHlmUFOA4rBIc5T33LZAlF0ysvkBUJSusigi5Y
         3vZ1Q71sM2+HrTz4sTn03qLg5s+lFmhd5rYdx6u7KVFLp+sWF0afALK/f9kfpBtdo5dg
         9YLQ==
X-Gm-Message-State: AOJu0Yx1BmR+nCRxAwL5zJrENw9rJflWtdQqjKh1GOroJXAhZaA6b9Nr
	EJ3y5Jh6fZ8/I+JqwXP47PpDZHUykmlYNY99n2WwQxoefSbpQqHKktZlcuKtOxfJIQ7f+zJGdCt
	ZlB1cxRexKwF80xZsk5+fYm9MxpY=
X-Gm-Gg: ASbGncuTFRGL9zLZcYJsJdaGKYCsUN97r+SSb0Wdut7TM3MiRdA+fYLa+jwKJf82f/P
	l8QYv+NqbB2zb+l2X7bw5lM5ujU2UYaCL8D4/5RzVvUtmwjEqbdGGe6CvXY/hHJ7Iv4ZzsVRRb2
	KEuvwj/tiv3WRx4rrk4DogG5Jy/O3XXZcL9lkfAabxFyM=
X-Google-Smtp-Source: AGHT+IFc566dmbdZW0yzt36qWQzFCaVBvUS7phKwlhL5q5Kga6QIYGQYBMHoSKQX8uVnDbFeX1YlnihOKO6IsLkZR/M=
X-Received: by 2002:a17:907:26ce:b0:ac7:2fbb:ba5 with SMTP id
 a640c23a62f3a-ace5a27b3c4mr435579766b.7.1745565403365; Fri, 25 Apr 2025
 00:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425014542.62385-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250425014542.62385-1-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 25 Apr 2025 09:16:06 +0200
X-Gm-Features: ATxdqUEmImWgH7v22vD-PwlEpBx_wPVk31qkVOLE99MQMZWAjuIEy9udnbDldAc
Message-ID: <CAP01T74-Ws_gyZ9vSdKB4iaD5r4xjpvOFAsvuBxW5OHTy=stPw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: Add namespace to BPF internal symbols
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 03:45, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add namespace to BPF internal symbols used by light skeleton
> to prevent abuse and document with the code their allowed usage.
>
> Fixes: b1d18a7574d0 ("bpf: Extend sys_bpf commands for bpf_syscall programs.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

