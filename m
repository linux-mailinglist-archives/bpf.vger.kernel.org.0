Return-Path: <bpf+bounces-71333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48088BEEE37
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 00:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEC4C4E5339
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091F7254864;
	Sun, 19 Oct 2025 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmRJRo7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF241F37D4
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760913036; cv=none; b=FHbjh4EJnasoyDWjlPJgOwS6nlRBFu2L2bMo9+K1GeBWLI5YI+/m2DzR1iDk1SqehvklhVvl1F7e9ge4/I0VYFsFSiMtB+UwJjQ/Ifnx70N54r9qLcc1tUbWZbrV91vQyAyShugd6U/mldBWP0exZ2n0tndita/BbApzaeQl/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760913036; c=relaxed/simple;
	bh=1VyNDB02vhSBB7FEJy9+MvvYx7rYtvfZUUI8FZN4GJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prle4shSIPs5JoF+vQcFAHXxFpe/+67tjd7st7n1/kjc2e+dQW7EMo4OECWPy+j9PB8p2u4yuE9Zn37gbKqWcC36PZZSzrV4BoSS3Gi1OiWv9tfERZhEhAlkQdGqIdLjH20HBQU9l7IZJrFbomyDk5nLHGM4595BT7uAtPOqkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmRJRo7x; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77f5d497692so4653783b3a.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760913034; x=1761517834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln/mU8zYFji5KHoiExwHL0rc07J4kGX/OgUlOJfH7cY=;
        b=CmRJRo7x4ybiQ7OHOHM6xIrmEy6zDXiaLy36OlN+GwEsJq+VulIed5YtVGfvTOmNDk
         1kGqqJ/vnb54lG7af3QVBMVaFTQtiKemyuYEUAREci45iUYnw7qWYkjGPXGZG58QTfWm
         fVXdWXn37EZqnWGhbBkvo536q2fRBYfR6s4L3xcR6eVVtiCvpval2wra0UKRFWk3vQ9U
         A4qn8kd80D5DBByDNYX0JzPoJbn0UQhFR+Knu6SgWc+hSOztsgGh16wgHUwCrXb448Jt
         zJGXmF7fkY87vAgPs4nHt4xRHava7kYuWAR0WwHUC6WNr+DX30RdnJxwv8By+fG/UjJ1
         Tbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760913034; x=1761517834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln/mU8zYFji5KHoiExwHL0rc07J4kGX/OgUlOJfH7cY=;
        b=GQlTdBn7Z/LpSBx7/pmQ1Dz5mA4sYhMTTmp+QUXsG31jJIKSKo0qbjf2Rx6+kXFoLm
         DlIT8Si9HjOuL2k+ok/zanhas58cFoAE1b3UcyqcV1F4TkKeJbBTk+5wBv92Gq3rqung
         oSJP1CZSGkwIUyzcGaON+BnT+ugzAconHryVOOzyegklpFDHSFMc6nTkAFKfZ2EHfUHT
         laXW9rFdZsNOHhjOXw2tcmd0CuQPY9B+tUjjoEdsDE5wN/7Ir61E6bAV90M2CMLnc6y1
         /vC9irzjSKyU3I2Jo1tKoRFprcNvDWtspmhfNv/sbNHhI9iZBydk9iGGJ0ya7qYzPsPm
         F9jg==
X-Forwarded-Encrypted: i=1; AJvYcCW+E+Si6EjjBHFxCE7eE5X6h/dq+FbI6HvleuTN4Xx7vzhohOAbBLuFWIyoXyIJNjqaoS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx993yGAKJ6OPXxNiWVn+GFqIsg9VVib/S0hnFUOQ+df1mMsgi4
	UR64Mjxi5hUJYDgYdKKSa4JNYg8bMK8/pRhLw84VosiUhzQfCC36RrYd
X-Gm-Gg: ASbGncuktfaLaSZRHj17kPIhvI+H/T6/UgrynDHDsVxwrGMvhC4tXFWUosQkxEdvxZa
	yh9CRRMxVlZ6CmGvbq5rusivBQPa7EWdXCd7fNUu+/i1Bc09nM23HVLlRuoFXV911HYakIuTC/D
	YpH16HovB9rh61+o0XnWS0TtYNom6W03nkoiG+b2YYE9JUAaENaTOzvqlF1NOL4cthz3znX2zUt
	LQg1Vg0wcfSlI2xK1t7Fj1mbhRA5jojVdBjrJHdHiNnbyfRhSwfsRuUMoXQy8agHtdAOFnO5BTT
	bu0+36AWI1N0M/rC3q8QRQBPMDrznJ730C13NF1r1Q5Q2b0thFX83ZOv80tsEgR3X64L6bwf/Ry
	A/39KG2UBb2lhuD7Z9/1h4f0Jp3WlIWrGyEcSeA72xFRi3bDGl0vbw0pVltJSx7ym9LIDpAOV
X-Google-Smtp-Source: AGHT+IGnF5Srcir7/6CWxen50eglfngyYXHZEDVZiPbz8BkFINxUwaCDRPwDVsgdeNlWE25tkflYZA==
X-Received: by 2002:a05:6a20:6a1b:b0:319:fc6f:8adf with SMTP id adf61e73a8af0-334a85340b4mr14174653637.12.1760913034079;
        Sun, 19 Oct 2025 15:30:34 -0700 (PDT)
Received: from fedora ([45.112.145.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76645c61sm6317715a12.3.2025.10.19.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 15:30:33 -0700 (PDT)
From: Noorain Eqbal <nooraineqbal@gmail.com>
To: alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	david.hunter@linuxfoundation.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	nooraineqbal@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	song@kernel.org,
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
Date: Mon, 20 Oct 2025 04:00:06 +0530
Message-ID: <20251019223006.26252-1-nooraineqbal@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
References: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> Why do you think irq_work_run_list() processes bpf ringbuf in
> the above splat?

In the syzbot reproducer, GDB shows that when bpf_ringbuf_free() is entered 
the ring buffer's irq_work was still pending when the map was being freed.

    (gdb) p rb->work
    $5 = {
      node = {llist = {next = 0xffffffff8dc055c0 <wake_up_kfence_timer_work>},
              {u_flags = 35, a_flags = {counter = 35}}},
      func = 0xffffffff8223ac60 <bpf_ringbuf_notify>,
      irqwait = {task = 0x0}
    }

Here, `u_flags = 0x23` indicates IRQ_WORK_PENDING and IRQ_WORK_BUSY
are set, which shows that irq_work for the ring buffer was still queued
at the time of free. This confirms that `irq_work_run_list()` could
process the ring buffer after memory was freed.

On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> Sort-of kind-of makes sense, but bpf_ringbuf_free() is called
> when no references to bpf map are left. User space and bpf progs
> are not using it anymore, so irq_work callbacks should have completed
> long ago.

You're correct that normally all irq_work callbacks should have completed
by the time bpf_ringbuf_free() is called. However, there is a small
race window. In the syzbot reproducer (https://syzkaller.appspot.com/text?tag=ReproC&x=17a24b34580000),
the BPF program is attached to sched_switch and it also writes to the
ring buffer on every context switch. Each forked child creates the
BPF program and quickly drops the last reference after bpf_ringbuf_commit()
queues an irq_work. Because the irq_work runs asynchronously, it may still
be pending when bpf_ringbuf_free() executes, thus creating a small race
window that can lead to use-after-free.

Adding `irq_work_sync(&rb->work)` ensures that all pending notifications
complete before freeing the buffer.

Thanks,
Noorain Eqbal

