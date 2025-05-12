Return-Path: <bpf+bounces-58044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C163AB44C1
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A621895018
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06E297A60;
	Mon, 12 May 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Ua+mzMWE"
X-Original-To: bpf@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06820296D32;
	Mon, 12 May 2025 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077434; cv=none; b=MQUpRyXG+qchCSoZ5bQelZOTzNwvFdmPLXPSKdgffUI5P6wcCyx173cjdYmMSkYeg6ENXXiXxcAOOQy0VbsKbkWpxcSJ0v9xlGxji2erZN1xGIcF3zz/XazL8ASRnK+SZHoJV/JrhnVcySGxbxcb0URbE3ce80NapvQhEQC53/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077434; c=relaxed/simple;
	bh=JYFMfi6NvvswXPKWzX0gygRa/IzGaP7udvSOKwN43uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+wJfVUMUjrIlg6zldRDtQbRG23PBmxVddh5J1MQEo5QvhpxGRN3Gof0nR3ttJzGAiy9d7AhO5lBXJmyxDGiMk3j9HcOnCnMN4w5bbmbohdI6Lh3XXUpJ1TxUxbFflBPfnoPaFumGQ9cAkUwdVu1mB/CpTA+cV/1IO9IoDvhRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Ua+mzMWE; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 96F8222156E;
	Mon, 12 May 2025 21:17:09 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1747077429; bh=afmavmvu6ERDtlMiPPJ+izaGZ9Iq701zLO8sCs2tIco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ua+mzMWEms8yJSGpZYB7PR0OKMcs0mWSl8mpJqWvwlyX6kgNqi9DWBmmxFNAatcvg
	 pq54hTcVWvsU0lVlvm7aX3sMUK9KLhdEhi64XCWeEE70XNHoCdqAl9CKvD4kuk8Fc/
	 14GJVTlMTUJbJXzZs9uqXG4+iPl+GyPbpSob24Rd5RXKThSO43pA1fLypjHrFRGsIx
	 qU4pbZjlhKzlPGkkGdhRP9/EP4c+ZhBvqclXvTFPsV4nkLFNtnq2vyvT8XWmfJXuFx
	 DWvZErJJi1as2fbfvJTl5/+FaEzkeqNMAXo1+LE+VnxzLCMj5R7OIajbwJrIJUVhXK
	 Jezc4JcM6dXKA==
Date: Mon, 12 May 2025 21:17:08 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Rong Zhang <i@rong.moe>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Brian Gerst <brgerst@gmail.com>, Borislav Petkov
 <bp@alien8.de>, bugzilla-daemon@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: bpf: abort dispatch if device destroyed
Message-ID: <20250512211708.35a0d8df@meshulam.tesarici.cz>
In-Reply-To: <20250512152420.87441-1-i@rong.moe>
References: <20250506145548.GGaBoi9Jzp3aeJizTR@fat_crate.local>
	<20250512152420.87441-1-i@rong.moe>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 23:24:19 +0800
Rong Zhang <i@rong.moe> wrote:

> The current HID bpf implementation assumes no output report/request will
> go through it after hid_bpf_destroy_device() has been called. This leads
> to a bug that unplugging certain types of HID devices causes a cleaned-
> up SRCU to be accessed. The bug was previously a hidden failure until a
> recent x86 percpu change [1] made it access not-present pages.
> 
> The bug will be triggered if the conditions below are met:
> 
> A) a device under the driver has some LEDs on
> B) hid_ll_driver->request() is uninplemented (e.g., logitech-djreceiver)
> 
> If condition A is met, hidinput_led_worker() is always scheduled *after*
> hid_bpf_destroy_device().
> 
> hid_destroy_device
> ` hid_bpf_destroy_device
>   ` cleanup_srcu_struct(&hdev->bpf.srcu)
> ` hid_remove_device
>   ` ...
>     ` led_classdev_unregister
>       ` led_trigger_set(led_cdev, NULL)
>         ` led_set_brightness(led_cdev, LED_OFF)
>           ` ...
>             ` input_inject_event
>               ` input_event_dispose
>                 ` hidinput_input_event
>                   ` schedule_work(&hid->led_work) [hidinput_led_worker]
> 
> This is fine when condition B is not met, where hidinput_led_worker()
> calls hid_ll_driver->request(). This is the case for most HID drivers,
> which implement it or use the generic one from usbhid. The driver itself
> or an underlying driver will then abort processing the request.
> 
> Otherwise, hidinput_led_worker() tries hid_hw_output_report() and leads
> to the bug.
> 
> hidinput_led_worker
> ` hid_hw_output_report
>   ` dispatch_hid_bpf_output_report
>     ` srcu_read_lock(&hdev->bpf.srcu)
>     ` srcu_read_unlock(&hdev->bpf.srcu, idx)
> 
> The bug has existed since the introduction [2] of
> dispatch_hid_bpf_output_report(). However, the same bug also exists in
> dispatch_hid_bpf_raw_requests(), and I've reproduced (no visible effect
> because of the lack of [1], but confirmed bpf.destroyed == 1) the bug
> against the commit (i.e., the Fixes:) introducing the function. This is
> because hidinput_led_worker() falls back to hid_hw_raw_request() when
> hid_ll_driver->output_report() is uninplemented (e.g., logitech-
> djreceiver).
> 
> hidinput_led_worker
> ` hid_hw_output_report: -ENOSYS
> ` hid_hw_raw_request
>   ` dispatch_hid_bpf_raw_requests
>     ` srcu_read_lock(&hdev->bpf.srcu)
>     ` srcu_read_unlock(&hdev->bpf.srcu, idx)
> 
> Fix the issue by returning early in the two mentioned functions if
> hid_bpf has been marked as destroyed. Though
> dispatch_hid_bpf_device_event() handles input events, and there is no
> evidence that it may be called after the destruction, the same check, as
> a safety net, is also added to it to maintain the consistency among all
> dispatch functions.
> 
> The impact of the bug on other architectures is unclear. Even if it acts
> as a hidden failure, this is still dangerous because it corrupts
> whatever is on the address calculated by SRCU. Thus, CC'ing the stable
> list.
> 
> [1]: commit 9d7de2aa8b41 ("x86/percpu/64: Use relative percpu offsets")
> [2]: commit 9286675a2aed ("HID: bpf: add HID-BPF hooks for
> hid_hw_output_report")
> 
> Closes: https://lore.kernel.org/all/20250506145548.GGaBoi9Jzp3aeJizTR@fat_crate.local/
> Fixes: 8bd0488b5ea5 ("HID: bpf: add HID-BPF hooks for hid_hw_raw_requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rong Zhang <i@rong.moe>

Yes, this patch fixes the BUG and subsequent lock-ups in my scenario
(suspend with a Bluetooth keyboard). Thank you!

Tested-by: Petr Tesarik <petr@tesarici.cz>

Petr T

> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c
> b/drivers/hid/bpf/hid_bpf_dispatch.c index 2e96ec6a3073..9a06f9b0e4ef
> 100644 --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -38,6 +38,9 @@ dispatch_hid_bpf_device_event(struct hid_device
> *hdev, enum hid_report_type type struct hid_bpf_ops *e;
>  	int ret;
>  
> +	if (unlikely(hdev->bpf.destroyed))
> +		return ERR_PTR(-ENODEV);
> +
>  	if (type >= HID_REPORT_TYPES)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -93,6 +96,9 @@ int dispatch_hid_bpf_raw_requests(struct hid_device
> *hdev, struct hid_bpf_ops *e;
>  	int ret, idx;
>  
> +	if (unlikely(hdev->bpf.destroyed))
> +		return -ENODEV;
> +
>  	if (rtype >= HID_REPORT_TYPES)
>  		return -EINVAL;
>  
> @@ -130,6 +136,9 @@ int dispatch_hid_bpf_output_report(struct
> hid_device *hdev, struct hid_bpf_ops *e;
>  	int ret, idx;
>  
> +	if (unlikely(hdev->bpf.destroyed))
> +		return -ENODEV;
> +
>  	idx = srcu_read_lock(&hdev->bpf.srcu);
>  	list_for_each_entry_srcu(e, &hdev->bpf.prog_list, list,
>  				 srcu_read_lock_held(&hdev->bpf.srcu))
> {
> 
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3


