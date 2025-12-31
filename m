Return-Path: <bpf+bounces-77627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B697ACEC790
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53043022A81
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608002FFFA5;
	Wed, 31 Dec 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUChjnIp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965F26F2AF
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767205548; cv=none; b=sDktD7c5QcYw8A63i3vVjwPKwGUb1KzY5bUX3fvtzEIl5I03SMPQGXy/HYFSLYqxZjjnMDttqBHHVYlcr/7eKDl0+sBfjlyV7nPFM1LLbqH0ABKI9RYiLD8ohJsseveYtVu6voD+Rs8y6biJVkFl4LVSr2pTo3DzmakKtpUFaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767205548; c=relaxed/simple;
	bh=U3NBKYIFRrWp5zzB7ZM/vooQmiqdou95tqZ9nE4O/4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLKjOITZtA6FXA+/ppEk7dJHUzXcfpcS/kMpbMbWz3NTKBsaKgIVQlS+Afom7+GDgfrbqKpmC+L5QWt6MjocbDLYqn3A5vanYf5IuLTpFwIlFQMtJf01DKjjrNpXG8J8t3MlOEQu/gOJNh5WZoJt/eEitcKg/0f5MTbJ5NCxhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUChjnIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649C1C19425
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767205548;
	bh=U3NBKYIFRrWp5zzB7ZM/vooQmiqdou95tqZ9nE4O/4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FUChjnIp5egsCbQTW7DQMyaqaLj/0p7A4+qmSM/tIYlV7hej3oW+P2VxclHGaW1F5
	 NaQKW/gjzSNFuj6P2n29Ar2wrF3HoTDqg1iMXWkyGnh+1zZqSxnYyFxOgUY/65eacv
	 yO8d64oNvvi5Rx3hT72UzJTTRV8atIPRKa5TisrwiqUh6jOIIlkJxCPxLxqaSSNsYS
	 q1v8BAah8efO054OulrrZ3zeeAA2WcU+1aPiBGKqvwdOz2oUKUhrE7GEy4TJLVjmhg
	 0kFMFISvGDttcGf1tdK3Op821GjZ6Yo0HzXzBzr1v1KwwdljGhywzcYD59Lybk2L+j
	 xrjTefn/+pLuQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b83b72508f3so52644566b.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 10:25:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlktWAuTxZwxNBM5IA8TC6KxWxDEz9mdyn31ZY6m0fi4dfd2/78Tp72p0UOXWHXwfyw6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhJtg+dtnEmI3XTH+WJaLl8XNgrN+Gav6YWN+hJrTEmE+Y4t7
	utCIIBXaIextbWi1/OlFJJFZkCi/62Gg6qq/BorZC0T6LqR87/8UEe0YuhYTkAKSOTWioc4QqU2
	5yilYOUgWrNUG77Tm+MZwaSMEqWST8V8=
X-Google-Smtp-Source: AGHT+IG7DLzP1HbQYK+9ZYr0vcECBLfWNsZrTYk1ymQRdXWf/l56Ds3qg4QqVJxuqxZLQIkigGIe3m4X/T3jeL84bEA=
X-Received: by 2002:a17:907:7207:b0:b83:7198:d425 with SMTP id
 a640c23a62f3a-b837198e005mr1168729666b.37.1767205546779; Wed, 31 Dec 2025
 10:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231171118.1174007-1-puranjay@kernel.org> <20251231171118.1174007-10-puranjay@kernel.org>
 <CAADnVQ+nK7bF6rTZJ=yF1L4+wifS0KN1bCNbOo7j7OJZRPaDNw@mail.gmail.com>
In-Reply-To: <CAADnVQ+nK7bF6rTZJ=yF1L4+wifS0KN1bCNbOo7j7OJZRPaDNw@mail.gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 31 Dec 2025 18:25:35 +0000
X-Gmail-Original-Message-ID: <CANk7y0iGa2xbbqE1iUEAZtbozUufBcRQgKfbhWQx9DG8WG4wgw@mail.gmail.com>
X-Gm-Features: AQt7F2o0mnGn295ZbYxbosAyyMtiBHI9YZFGqk3hnOyaXL9QzJIedhFZaP5vOuo
Message-ID: <CANk7y0iGa2xbbqE1iUEAZtbozUufBcRQgKfbhWQx9DG8WG4wgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 9/9] HID: bpf: drop dead NULL checks in kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 6:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 9:12=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > As KF_TRUSTED_ARGS is now considered default for all kfuns, the verifie=
r
> > will not allow passing NULL pointers to these kfuns. These checks for
> > NULL pointers can therefore be removed.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  drivers/hid/bpf/hid_bpf_dispatch.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
>
> Benjamin,
>
> please run this patch set through your testsuite.
> We don't expect breakage, but please double check and ack.
>

I did run the hid bpf selftests, I am not sure if this is enough:

[root@alarm hid]# ./hid_bpf
TAP version 13
1..20
# Starting 20 tests from 1 test cases.
#  RUN           hid_bpf.test_create_uhid ...
hid-generic 0003:0001:0A36.0001: hidraw0: USB HID v0.00 Device
[test-uhid-device-268] on 268
#            OK  hid_bpf.test_create_uhid
ok 1 hid_bpf.test_create_uhid
#  RUN           hid_bpf.raw_event ...
hid-generic 0003:0001:0A36.0002: hidraw0: USB HID v0.00 Device
[test-uhid-device-268] on 268
#            OK  hid_bpf.raw_event
ok 2 hid_bpf.raw_event
#  RUN           hid_bpf.subprog_raw_event ...
hid-generic 0003:0001:0A36.0003: hidraw0: USB HID v0.00 Device
[test-uhid-device-268] on 268
#            OK  hid_bpf.subprog_raw_event
ok 3 hid_bpf.subprog_raw_event
#  RUN           hid_bpf.multiple_attach ...
hid-generic 0003:0001:0A36.0004: hidraw0: USB HID v0.00 Device
[test-uhid-device-268] on 268
#            OK  hid_bpf.multiple_attach
ok 4 hid_bpf.multiple_attach
#  RUN           hid_bpf.test_attach_detach ...
hid-generic 0003:0001:0A36.0005: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_attach_detach
ok 5 hid_bpf.test_attach_detach
#  RUN           hid_bpf.test_hid_change_report ...
hid-generic 0003:0001:0A36.0006: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_change_report
ok 6 hid_bpf.test_hid_change_report
#  RUN           hid_bpf.test_hid_user_input_report_call ...
hid-generic 0003:0001:0A36.0007: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_user_input_report_call
ok 7 hid_bpf.test_hid_user_input_report_call
#  RUN           hid_bpf.test_hid_user_output_report_call ...
hid-generic 0003:0001:0A36.0008: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_user_output_report_call
ok 8 hid_bpf.test_hid_user_output_report_call
#  RUN           hid_bpf.test_hid_user_raw_request_call ...
hid-generic 0003:0001:0A36.0009: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_user_raw_request_call
ok 9 hid_bpf.test_hid_user_raw_request_call
#  RUN           hid_bpf.test_hid_filter_raw_request_call ...
hid-generic 0003:0001:0A36.000A: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_filter_raw_request_call
ok 10 hid_bpf.test_hid_filter_raw_request_call
#  RUN           hid_bpf.test_hid_change_raw_request_call ...
hid-generic 0003:0001:0A36.000B: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_change_raw_request_call
ok 11 hid_bpf.test_hid_change_raw_request_call
#  RUN           hid_bpf.test_hid_infinite_loop_raw_request_call ...
hid-generic 0003:0001:0A36.000C: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_infinite_loop_raw_request_call
ok 12 hid_bpf.test_hid_infinite_loop_raw_request_call
#  RUN           hid_bpf.test_hid_filter_output_report_call ...
hid-generic 0003:0001:0A36.000D: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_filter_output_report_call
ok 13 hid_bpf.test_hid_filter_output_report_call
#  RUN           hid_bpf.test_hid_change_output_report_call ...
hid-generic 0003:0001:0A36.000E: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_change_output_report_call
ok 14 hid_bpf.test_hid_change_output_report_call
#  RUN           hid_bpf.test_hid_infinite_loop_output_report_call ...
hid-generic 0003:0001:0A36.000F: hidraw0: USB HID v0.00 Device
[test-uhid-device-520] on 520
#            OK  hid_bpf.test_hid_infinite_loop_output_report_call
ok 15 hid_bpf.test_hid_infinite_loop_output_report_call
#  RUN           hid_bpf.test_multiply_events_wq ...
hid-generic 0003:0001:0A36.0010: hidraw0: USB HID v0.00 Device
[test-uhid-device-309] on 309
#            OK  hid_bpf.test_multiply_events_wq
ok 16 hid_bpf.test_multiply_events_wq
#  RUN           hid_bpf.test_multiply_events ...
hid-generic 0003:0001:0A36.0011: hidraw0: USB HID v0.00 Device
[test-uhid-device-309] on 309
#            OK  hid_bpf.test_multiply_events
ok 17 hid_bpf.test_multiply_events
#  RUN           hid_bpf.test_hid_infinite_loop_input_report_call ...
hid-generic 0003:0001:0A36.0012: hidraw0: USB HID v0.00 Device
[test-uhid-device-309] on 309
#            OK  hid_bpf.test_hid_infinite_loop_input_report_call
ok 18 hid_bpf.test_hid_infinite_loop_input_report_call
#  RUN           hid_bpf.test_hid_attach_flags ...
hid-generic 0003:0001:0A36.0013: hidraw0: USB HID v0.00 Device
[test-uhid-device-309] on 309
#            OK  hid_bpf.test_hid_attach_flags
ok 19 hid_bpf.test_hid_attach_flags
#  RUN           hid_bpf.test_rdesc_fixup ...
hid-generic 0003:0001:0A36.0014: hidraw0: USB HID v0.00 Device
[test-uhid-device-309] on 309
hid-generic 0003:0001:0A36.0014: hidraw0: USB HID v0.00 Device
[test-uhid-device-309] on 309
#            OK  hid_bpf.test_rdesc_fixup
ok 20 hid_bpf.test_rdesc_fixup
# PASSED: 20 / 20 tests passed.
# Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

