Return-Path: <bpf+bounces-54617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F084EA6E438
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 21:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A587C1892C8D
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD421C861E;
	Mon, 24 Mar 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KRzLfo4d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B11A2C06
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847697; cv=none; b=R5BDF/vMMY8umSlDy2RQV7juLNCCSr76F7AnhYu+VfPHvydpyHSNgd/TkTWOysf6uS37+MeTOEhAfKMR0GYjGysDc1W05rESdRbemGz3YZxDNvHGaZpBXEchVSPwEdEP7Xz953LntIXH/ZPTfF4oO0CgtRgdngndTvgrUmWAN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847697; c=relaxed/simple;
	bh=AbZ7GL7VFEwqgpUSkpVsKMsRFltmC+cCxsyUxbOHzFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+U7Ysi0Cb+Apnb1E6qnF9n1T3U/xwbKm/4FjSs8j6oZ+LsE/fBDPuWK0JN7O6IPuyXimvoCLawVS7W21kNZg+QMb3HXC7v11n2nbOw3zD+M3SeTc20AA+vF/sUGwVA4JCbwRUMo7hwHNiUU/cUbiU5RCjWLxaz5XQF2lrHKZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KRzLfo4d; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-394780e98easo2867531f8f.1
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742847692; x=1743452492; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbZ7GL7VFEwqgpUSkpVsKMsRFltmC+cCxsyUxbOHzFs=;
        b=KRzLfo4d4FquCMQgKxJcsVKIlrWlISrTNUi8yVX09hlu4Wu82W6r7CuiVU9mNfeY4j
         O0cPtY1Xew2N2+vuALP555KDoWrfduJt5L2Wuevk1CEG6v+7QeE/xp8eUXKNArawprQy
         mpzfMuKG9X1YVFy5UdmaPXnIhs5ZZtrMKxtPGsH5cGm/cbPRVb4CQPR51ov7rcJ/3H2W
         785bJIC1PJs13pMEG21vRHB1a96B1NqT9k2d+EjWucdIRWup30qlTRoZOWYJjqmkiVoP
         mFuV8T2jNAxeDaY9lgv9euWlsyO6coKrOhhw+aofnvE3Rm850rN+Zf0bQqNTS8B2pP5q
         btlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847692; x=1743452492;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbZ7GL7VFEwqgpUSkpVsKMsRFltmC+cCxsyUxbOHzFs=;
        b=inn2cn9H3IesNLlYnJN+0F7aoaDRmyNvWqpcm9ieolmzeJ7UbDga9rCWX6U2dUCRsh
         4uLDJ4pDrgaJIbKQQcM81pA8dHuUoE1+RqQ3KNO89HnCE4razsLoKKYo/SnMF32roiXD
         65MAakj2uiYYzQfN4wIbUc5YgYhWxOAIzltGdTtlNUh9nWYsr5eXJKTYlx+lvosTAYMF
         7peEBDPPev1oQSjbMEaIY1NKiGog988ClTd+bk7p00kiVnsB88/kekwFYxlRJL1P700o
         tYf5qKc7IaC8j/+WbZXdU/AuQN7XxQ9r8IQAsO066GgqutMm7dWYRYjA4sDsikuK4KjO
         Nb/A==
X-Gm-Message-State: AOJu0YyMpYak4T9jedPHX9kAmohutLlhBQUlQGYKQTHqKcfKj2gkKzDO
	6jf8x4lapRvrbz+peraJRIsQnc8ZA3G0um40JmZZqvityUO5oTPJPpsrq/czOoYA+Sclxw5zaUf
	8FS+6ew==
X-Gm-Gg: ASbGncugKSJJ0MtAQ97jMOaW0OzGMIzPuoJgObmu8EkcCL4kE1PWUxjBMzPp/0lRzen
	f+N4cjv6al9tVrkcw2zrEh+0mXGHeIaQd6qHpVa3lL9lAHIf4kbR1YYUpzY2fkYXJ3MctM2F5sS
	0o9vk8kXB5m1ib4NGFkksqUnoxJ0J3vFyMV6+JOYLNp/vanlS9fB+aUJrV2ZwBCpLt7xfxvLXpd
	wGPhC/+l4RXlM9afR0UgPFJdzuAlFIhvoaJ+KSJSfUGEeVFJfDsd0TYkCmTnkXllojsIHvGXLzO
	mwyRFL1bgy9S3jDLE5Kg0OMyeof7QEFqfw31kYIVJv2iJiCLf0shWjW8BSuifVtkAPnbrh1akL1
	oaUy0tU1JH2MgMq/1klCHCcA6KYNtRB+kaETIB0ktcjNp3zPz
X-Google-Smtp-Source: AGHT+IE/Uktokd62TqTQrvwAdlR4ZjJLb7qSWRc4IcsS6jqJjiOP89kt/zSCgDB60DxpwX3BSpzONg==
X-Received: by 2002:a05:6000:2b08:b0:391:481a:5e75 with SMTP id ffacd0b85a97d-3997f8fa20emr9047499f8f.22.1742847692620;
        Mon, 24 Mar 2025 13:21:32 -0700 (PDT)
Received: from u94a (2001-b011-fa04-36f3-4b5c-3f1e-6259-1c9f.dynamic-ip6.hinet.net. [2001:b011:fa04:36f3:4b5c:3f1e:6259:1c9f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8d4f39ef9sm3711382a12.71.2025.03.24.13.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:21:32 -0700 (PDT)
Date: Tue, 25 Mar 2025 04:21:24 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org
Subject: [LSF/MM/BPF TOPIC] BPF in Stable Kernels
Message-ID: <6fc3emipotqfegfbrljihok3fae4wqdygme3l5tzd6wqgql2cw@sxa54sybk4m6>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Start a thread to host discussion.

Slide can be found at
<https://speakerdeck.com/shunghsiyu/bpf-in-stable-kernels>

Shung-Hsi

