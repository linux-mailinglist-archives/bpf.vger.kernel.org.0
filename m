Return-Path: <bpf+bounces-54983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89432A76CE1
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB097188C205
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B22B216386;
	Mon, 31 Mar 2025 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg/SNbRb"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90826AF6
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 18:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743445542; cv=none; b=inll7jJR2uZwzBPJqKU+tEd9yELRHyOJkR9t5o7Qhq5jNlyat3w+G5ZRk6qo9d+mKsACfC726yZyrdmuZ+TduSDPmcFtKXK9sSO9jmHGv4TvE9DCJtT0TfR6KKycQi1C1dOr2+CkZDgWZSb/MEWqxSSSkeA5D4SFhvd252LO64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743445542; c=relaxed/simple;
	bh=pu96DIbooOmxV8pJCtAzjKBE1wadXve8KxneYS4ywuo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=jtuwsX+qQRfltf0l//7htwaKLV+Gk6FPUaEKG8xrmcjt+SeYx9IJok/u6GyI5SiDn9mSLOU5d26V/KcaQtT2310lCPn+Gg5Ea4xOuqZfnKJkKLa0+9FjNVh/UTFUCPFpuB7y2DJ2A7mVSNSi+tPKPv04AIGEZb5mGN0QBblcDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg/SNbRb; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743445537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FvBj1iEW0gd5QfOo+0DeNiD0z9d0Jhykfjty6wB3Svo=;
	b=Tg/SNbRbcnK+XkArnyTt2/oKbrap2FmDE1LPGZFCbdu88fZLQse/EQv22my6pfx9J7/Yjy
	4ZRg7hgaGMfDrl7tUQ0A2UqeD2yCnNFm+WBwgQ/pmuzSPCd9EohX2jBQiMJMD1OFRdDzYB
	OnrkUbG8CSbIJIyoXJDqI7XJOq83djI=
Date: Mon, 31 Mar 2025 18:25:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <7adb418e282468fcd5dc10c05790614e622579d4@linux.dev>
TLS-Required: No
Subject: s390x: selftests/bpf are failing on CI
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, bpf@vger.kernel.org,
 kernel-team@meta.com
X-Migadu-Flow: FLOW_OUT

Hi Ilya,

After recent merges from upstream, CI started failing both on bpf and
bpf-next trees. Yonghong Song and Song Liu submitted a couple of fixes
that are already applied to bpf tree, but there are still failures on
s390x.

https://github.com/kernel-patches/bpf/actions/runs/14163772245

Could you please investigate?

A snippet from the log:

    #11      atomics:OK
    trace_kprobe: Could not probe notrace function __s390x_sys_bpf
    trace_kprobe: Could not probe notrace function __s390x_sys_nanosleep
    trace_kprobe: Could not probe notrace function __s390x_sys_nanosleep
    trace_kprobe: Could not probe notrace function __s390x_sys_nanosleep
    trace_kprobe: Could not probe notrace function __s390x_sys_nanosleep
    trace_kprobe: Could not probe notrace function __s390x_sys_nanosleep
    test_attach_probe:PASS:skel_open 0 nsec
    test_attach_probe:PASS:skel_load 0 nsec
    test_attach_probe:PASS:check_bss 0 nsec
    test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
    test_attach_probe_manual:PASS:uprobe_offset 0 nsec
    libbpf: prog 'handle_kprobe': failed to create kprobe '__s390x_sys_na=
nosleep+0x0' perf event: -EINVAL
    test_attach_probe_manual:FAIL:attach_kprobe unexpected error: -22
    #12/1    attach_probe/manual-default:FAIL
    test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
    test_attach_probe_manual:PASS:uprobe_offset 0 nsec
    libbpf: failed to add legacy kprobe event for '__s390x_sys_nanosleep+=
0x0': -EINVAL
    libbpf: prog 'handle_kprobe': failed to create kprobe '__s390x_sys_na=
nosleep+0x0' perf event: -EINVAL
    test_attach_probe_manual:FAIL:attach_kprobe unexpected error: -22
    #12/2    attach_probe/manual-legacy:FAIL
    test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
    test_attach_probe_manual:PASS:uprobe_offset 0 nsec
    libbpf: prog 'handle_kprobe': failed to create kprobe '__s390x_sys_na=
nosleep+0x0' perf event: -EINVAL
    test_attach_probe_manual:FAIL:attach_kprobe unexpected error: -22
    #12/3    attach_probe/manual-perf:FAIL
    test_attach_probe_manual:PASS:skel_kprobe_manual_open_and_load 0 nsec
    test_attach_probe_manual:PASS:uprobe_offset 0 nsec
    libbpf: prog 'handle_kprobe': failed to create kprobe '__s390x_sys_na=
nosleep+0x0' perf event: -EINVAL
    test_attach_probe_manual:FAIL:attach_kprobe unexpected error: -22
    #12/4    attach_probe/manual-link:FAIL
    libbpf: prog 'handle_kprobe_auto': failed to create kprobe '__se_sys_=
nanosleep+0x0' perf event: -ENOENT
    test_attach_probe_auto:FAIL:attach_kprobe_auto unexpected error: -2
    libbpf: prog 'handle_kretprobe_auto': failed to create kretprobe '__s=
e_sys_nanosleep+0x0' perf event: -ENOENT
    test_attach_probe_auto:FAIL:attach_kretprobe_auto unexpected error: -=
2
    test_attach_probe_auto:PASS:auto-attach should fail for old-style nam=
e 0 nsec
    test_attach_probe_auto:PASS:attach_uretprobe_byname 0 nsec
    test_attach_probe_auto:FAIL:check_kprobe_auto_res unexpected check_kp=
robe_auto_res: actual 0 !=3D expected 11
    test_attach_probe_auto:FAIL:check_kretprobe_auto_res unexpected check=
_kretprobe_auto_res: actual 0 !=3D expected 22
    test_attach_probe_auto:PASS:check_uretprobe_byname_res 0 nsec
    #12/5    attach_probe/auto:FAIL

