Return-Path: <bpf+bounces-54619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F237A6E8DA
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 05:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25BC188C7E0
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 04:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476051A314D;
	Tue, 25 Mar 2025 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEsO0TJt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652C8633F
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876934; cv=none; b=b5wMDu/UIdhPrzmfC337Yd3Y5MTUDsgEgL9rXvNu4AIc1DR1HlmnppYcShAT45/YKi4VWb7W00NbRGCstzK8REf9dNfY71pL6ujnQhTt3R80Il4rjNpd39N/r+Jv7duI86WGAgWkR2QNnDCXGNvgnjFYvjibRPfR+KsBqXVm94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876934; c=relaxed/simple;
	bh=pp6ZbS9UeYuz7oVMqa353ZXCNXt02VdkFc3MHYN4Hew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSVfLsgDq5yYYzNx8kszRDtEBTYEPiJ3dfnqZDLh0zAqMV9w5rmuIoYEl780H/lsBSKO5xxlm6yXIfXnJq9jE6JrdxHqNkWGoxV0c4Bi346h/tSG+SuD4UNZcdetZZWoyqVIuechpdL8Spa4vKbv6NwsJWUMFExLJP+uu3xVBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEsO0TJt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4768f90bf36so50171051cf.0
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742876932; x=1743481732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp6ZbS9UeYuz7oVMqa353ZXCNXt02VdkFc3MHYN4Hew=;
        b=FEsO0TJtgHXdu8dY7A8XKwjWo6b0LyitXgXNEcnsQHAePIMulSqfxVxHPlB7ApGH+e
         BcEqohEWyGuOSeoBcptmsDZxFp7SfQAf9C11MlO/fr3C1+W0tCK6hDZYYLohYFGV4YMR
         ac8kPR6V01k2qCbBt451QkdKgR1dm3x/QjzD4MNinXEtyTIiQtVVosQwvw6qAv0yEEa+
         1wXpm6oAh5EVamoiUpKwiBP288s6muyrkrMUWX6Vej8MLi8xNiveatf5XYGZlciYfPjm
         gNMXvw74cHj3wHVMKIdH2I0WE4LQysNLNRlwdyasDSrX65E3Tq2oYapCpWuUtziWJf/Q
         zX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742876932; x=1743481732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp6ZbS9UeYuz7oVMqa353ZXCNXt02VdkFc3MHYN4Hew=;
        b=kAoAS8tl2RRQNA09K4iLpTanPkDIIBrM49rCIChdfZh+1aJgn5HD00hu/6xfblAVJ6
         oyS/33R4gtJRWYSMvVL9UJDSjaJ2FQsWwIoAYmyv3lQQ9f/LGJgEVguLdEQu2Pb8T55X
         3FlmIM7MeBFneTsateuLmogKKlS+1DCq8KkRAO0CQRojX4RgYfwIsyAGM+Nll/sSPqa6
         L4LCMNec/zIEcx9rsRNHwhQAlTwoaCvTpAtdBkw2tnjGmpFbxQNtd5dT9vJ4pelx8eCB
         I0lZyNlShDKOu9wq9gwTuaDSX8hr64QVcK/U3lGs8ezQUTI8zgoqKsqNYX0BKDUK6W8h
         3GkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzdN0VMb5Ak3EH4ODyysRKK93luFJOFbKO/48IL64xq/6PK1k5pGNRp5+mbfTq2txysjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Joo31dMwN72mEFX1TfVNvo6aNhZVKYXg0Db0gxnAR7hS4yEM
	92TcT+U89VRzhfXX5rM27nvurHwLYXjRUBAPoYO2tqG2GmpnByovlfiGzL2RD7bdJzxDYgK+dvN
	TZPkI+h2JmrPEaGjTdGQcSVgaBJpHcDQfhFMn
X-Gm-Gg: ASbGncvB8w6WLT3jUY2vIHp6HrwUCROydl9qsTFzpqlFjB1ATJ4a5HEOxyeatCela+B
	5FX1XonNUi7zuib9/AoC0VWeuiWNj/sJUEY+ZvrpBJoU6VwI2O6O7CJP7lwebDuXXs77Dexye4Q
	EKDGxjDnPtypKGOPY2E3HKzg+90Q==
X-Google-Smtp-Source: AGHT+IEk4eqKPSzGKY1+mBhTmBlhZ4wamfo5qiv4PteJPuafaGTKKSFX/5mQRuQ4kwCXVSYe9V4L6Il9Sj3Y43eFwRc=
X-Received: by 2002:a05:622a:2588:b0:476:8288:9563 with SMTP id
 d75a77b69052e-4771dd607c0mr194124491cf.10.1742876931987; Mon, 24 Mar 2025
 21:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324083051.3938815-1-edumazet@google.com> <20250324111817.GA14944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250324111817.GA14944@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 05:28:41 +0100
X-Gm-Features: AQ5f1JpDNlWAkzmCY5RVAqO5XFqXmRAO1sjpsACH8OWOtorMBnMSQtaAvCYWiL0
Message-ID: <CANn89iJ1by2zbasXDi7+_Y0=9J8no0r5GcpeN4SEAG_Nxvkp+A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/alternatives: remove false sharing in poke_int3_handler()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, bpf@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Greg Thelen <gthelen@google.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>

>
> This is unreadable due to the amount of pointless repetition.

Thanks, I am trimming the changelog in v3.

