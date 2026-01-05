Return-Path: <bpf+bounces-77835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A4CF446E
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 16:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92853300E41E
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8927FD43;
	Mon,  5 Jan 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIZu0c3C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D02F90C5
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624775; cv=none; b=iVdAlkr14akgC3PIPh4erVKi+xpWtJThLiZ0BbZy06GBEIgCPaGfg06TR7tjQtBIOGZVd5f/ETHOHJwBc0XmDHrO7pBxTVcCFNTJqJNJvXSDfw8mAp1BLA4IdBjNGJzt/30oWvF/TJP99jrOEBGQ6zLHnv9IBU3csHv60Gs06B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624775; c=relaxed/simple;
	bh=SN0dLY9uo9qKcO8ZuMjbnONT4UMwvhX5u+DtxJduDOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm6Z/SATexIjILwhJdHWrBVif8OwSg6oc0oToUF5B8sJHAulaqf5Uv1hQebyNfHrpKkSvu7gttiuLcVQffNi2pzN7srkwQsHyBMAbhZKIFUMGkATEnzBBZfDDZaPnsylg8rKfLXAbJjLP6+pg9mxeGurlS3vs6wRSBbRPl4kEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIZu0c3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2834C116D0;
	Mon,  5 Jan 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624774;
	bh=SN0dLY9uo9qKcO8ZuMjbnONT4UMwvhX5u+DtxJduDOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIZu0c3COras0LSqONQ78XPcBWsMIMnQDYzuuNsNzO3PHOrXVlWemfc5Q1/pQJn88
	 2Rq81bsMP+6oTh7bKADUmeyrTx8OcRQa6TLltmXWrqKozu7j2COtHnL1kudsKGtVQJ
	 qJWxxwUasNhX4geiSQx4Xhp0E4zOzE9nz0zHS2QBq5gD6gSIegswNMPkWAJMeSI0wF
	 rhdl38iSMr7dYycUTQyfxrqT06R85Ih+HDbMoA4dW0yiFfon5cHLRzGjrnZp36MaFi
	 7i6x41GIyHrJshT81rXL/B2XcUbyrw9Q+tOVfA4MVrL4rzSpRnUFWwbdBUbsU7Cx9Z
	 FCedXmUxBz4Dg==
Date: Mon, 5 Jan 2026 15:52:49 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 9/9] HID: bpf: drop dead NULL checks in kfuncs
Message-ID: <ubyftmmyxd5inoctddmnzzzbmqjh2elacslv6wz7sbiko7ugaz@m2vwplpig3kr>
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-10-puranjay@kernel.org>
 <CAADnVQ+nK7bF6rTZJ=yF1L4+wifS0KN1bCNbOo7j7OJZRPaDNw@mail.gmail.com>
 <CANk7y0iGa2xbbqE1iUEAZtbozUufBcRQgKfbhWQx9DG8WG4wgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0iGa2xbbqE1iUEAZtbozUufBcRQgKfbhWQx9DG8WG4wgw@mail.gmail.com>

On Dec 31 2025, Puranjay Mohan wrote:
> On Wed, Dec 31, 2025 at 6:20 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 9:12 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> > >
> > > As KF_TRUSTED_ARGS is now considered default for all kfuns, the verifier
> > > will not allow passing NULL pointers to these kfuns. These checks for
> > > NULL pointers can therefore be removed.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > >  drivers/hid/bpf/hid_bpf_dispatch.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > Benjamin,
> >
> > please run this patch set through your testsuite.
> > We don't expect breakage, but please double check and ack.
> >
> 
> I did run the hid bpf selftests, I am not sure if this is enough:

Yep, this is enough, the C selftests are supposed to be comprehensive
enough.

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

> 
> [root@alarm hid]# ./hid_bpf
> TAP version 13
> 1..20
> # Starting 20 tests from 1 test cases.
> #  RUN           hid_bpf.test_create_uhid ...
> hid-generic 0003:0001:0A36.0001: hidraw0: USB HID v0.00 Device
> [test-uhid-device-268] on 268
> #            OK  hid_bpf.test_create_uhid
> ok 1 hid_bpf.test_create_uhid
> #  RUN           hid_bpf.raw_event ...
> hid-generic 0003:0001:0A36.0002: hidraw0: USB HID v0.00 Device
> [test-uhid-device-268] on 268
> #            OK  hid_bpf.raw_event
> ok 2 hid_bpf.raw_event
> #  RUN           hid_bpf.subprog_raw_event ...
> hid-generic 0003:0001:0A36.0003: hidraw0: USB HID v0.00 Device
> [test-uhid-device-268] on 268
> #            OK  hid_bpf.subprog_raw_event
> ok 3 hid_bpf.subprog_raw_event
> #  RUN           hid_bpf.multiple_attach ...
> hid-generic 0003:0001:0A36.0004: hidraw0: USB HID v0.00 Device
> [test-uhid-device-268] on 268
> #            OK  hid_bpf.multiple_attach
> ok 4 hid_bpf.multiple_attach
> #  RUN           hid_bpf.test_attach_detach ...
> hid-generic 0003:0001:0A36.0005: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_attach_detach
> ok 5 hid_bpf.test_attach_detach
> #  RUN           hid_bpf.test_hid_change_report ...
> hid-generic 0003:0001:0A36.0006: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_change_report
> ok 6 hid_bpf.test_hid_change_report
> #  RUN           hid_bpf.test_hid_user_input_report_call ...
> hid-generic 0003:0001:0A36.0007: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_user_input_report_call
> ok 7 hid_bpf.test_hid_user_input_report_call
> #  RUN           hid_bpf.test_hid_user_output_report_call ...
> hid-generic 0003:0001:0A36.0008: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_user_output_report_call
> ok 8 hid_bpf.test_hid_user_output_report_call
> #  RUN           hid_bpf.test_hid_user_raw_request_call ...
> hid-generic 0003:0001:0A36.0009: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_user_raw_request_call
> ok 9 hid_bpf.test_hid_user_raw_request_call
> #  RUN           hid_bpf.test_hid_filter_raw_request_call ...
> hid-generic 0003:0001:0A36.000A: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_filter_raw_request_call
> ok 10 hid_bpf.test_hid_filter_raw_request_call
> #  RUN           hid_bpf.test_hid_change_raw_request_call ...
> hid-generic 0003:0001:0A36.000B: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_change_raw_request_call
> ok 11 hid_bpf.test_hid_change_raw_request_call
> #  RUN           hid_bpf.test_hid_infinite_loop_raw_request_call ...
> hid-generic 0003:0001:0A36.000C: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_infinite_loop_raw_request_call
> ok 12 hid_bpf.test_hid_infinite_loop_raw_request_call
> #  RUN           hid_bpf.test_hid_filter_output_report_call ...
> hid-generic 0003:0001:0A36.000D: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_filter_output_report_call
> ok 13 hid_bpf.test_hid_filter_output_report_call
> #  RUN           hid_bpf.test_hid_change_output_report_call ...
> hid-generic 0003:0001:0A36.000E: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_change_output_report_call
> ok 14 hid_bpf.test_hid_change_output_report_call
> #  RUN           hid_bpf.test_hid_infinite_loop_output_report_call ...
> hid-generic 0003:0001:0A36.000F: hidraw0: USB HID v0.00 Device
> [test-uhid-device-520] on 520
> #            OK  hid_bpf.test_hid_infinite_loop_output_report_call
> ok 15 hid_bpf.test_hid_infinite_loop_output_report_call
> #  RUN           hid_bpf.test_multiply_events_wq ...
> hid-generic 0003:0001:0A36.0010: hidraw0: USB HID v0.00 Device
> [test-uhid-device-309] on 309
> #            OK  hid_bpf.test_multiply_events_wq
> ok 16 hid_bpf.test_multiply_events_wq
> #  RUN           hid_bpf.test_multiply_events ...
> hid-generic 0003:0001:0A36.0011: hidraw0: USB HID v0.00 Device
> [test-uhid-device-309] on 309
> #            OK  hid_bpf.test_multiply_events
> ok 17 hid_bpf.test_multiply_events
> #  RUN           hid_bpf.test_hid_infinite_loop_input_report_call ...
> hid-generic 0003:0001:0A36.0012: hidraw0: USB HID v0.00 Device
> [test-uhid-device-309] on 309
> #            OK  hid_bpf.test_hid_infinite_loop_input_report_call
> ok 18 hid_bpf.test_hid_infinite_loop_input_report_call
> #  RUN           hid_bpf.test_hid_attach_flags ...
> hid-generic 0003:0001:0A36.0013: hidraw0: USB HID v0.00 Device
> [test-uhid-device-309] on 309
> #            OK  hid_bpf.test_hid_attach_flags
> ok 19 hid_bpf.test_hid_attach_flags
> #  RUN           hid_bpf.test_rdesc_fixup ...
> hid-generic 0003:0001:0A36.0014: hidraw0: USB HID v0.00 Device
> [test-uhid-device-309] on 309
> hid-generic 0003:0001:0A36.0014: hidraw0: USB HID v0.00 Device
> [test-uhid-device-309] on 309
> #            OK  hid_bpf.test_rdesc_fixup
> ok 20 hid_bpf.test_rdesc_fixup
> # PASSED: 20 / 20 tests passed.
> # Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

