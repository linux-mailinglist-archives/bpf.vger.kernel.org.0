Return-Path: <bpf+bounces-33136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E89179BB
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 09:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1AC2870F1
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935E15B98F;
	Wed, 26 Jun 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpGmJ0uo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DAB15B55D
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387073; cv=none; b=BZ+9UFp230Eu+fCeZbKA8ZHsLaaiEdh/hrBQ+VAEXVsDr1dB87jHLqiQWnXY4NuMGuw966YYxa7loC2y3c6ATrPIqVzgDorsHbvKj/edmZ49lGfuTT94eIwuMNqbk+mPhSAbCY2WrESB8HvnrUAcsDfsBNMvTsxz3HuHgIXGdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387073; c=relaxed/simple;
	bh=zB4icRM9Ub79SmBMNaB54Jm/+NDXuZ52IyN0MH71FIA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uXtq+ZqBFe6B/L8KbBEfxCF7cq6zxjp7pfML9tWa/TD1Nqpl/TI153dLP48mUM7K21ISF2vnPwxZI5tFF4nBFI8u3ke5FDmnyxBnLmtFJHVFCYKvuGM+/16gybNGEcuo6QFItP0zPmsEQnD72YK2Voj4wY6iq4Upio0oAsZHRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpGmJ0uo; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-643f3130ed1so34600597b3.2
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 00:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719387071; x=1719991871; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBvWr5j2tiN0CkmjV+RGQ8aPgSRoPbTeFvUDG3XAb50=;
        b=BpGmJ0uobIsQRtcLJA72WUihTliSvevECVEIX7sDtxktBRUpmq1wvjAICidkeE1PkP
         EzlbPG5W7VvX+tvlfsCpxOlS8j6NDud83vZvg7FYW6HADoX/0LDdHhwRhTGZdz0IBF0G
         qG17KY+GQo9r9m/8sgP7rBTUuv5PNr27JZQFL12KHwMbvHqAosUJZYr0GptSwjE4B72S
         ONAjYMserZ82gRwpQMRCVwQ+3dy12nwVGxxHS2Z92nRgfo/fgRbjQW7aw1y55WJj8SKf
         /qTfg9GGzUo5pEPToNU5EHuOd/cy9P7RIwd9SNEJwCxb3KEKEhWPL+VYdXfveX5NxuXn
         MPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387071; x=1719991871;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBvWr5j2tiN0CkmjV+RGQ8aPgSRoPbTeFvUDG3XAb50=;
        b=gB0DOy6cAzQsvCZ7SpErAbM7tz0eowKtOJsgQLxZDKRMPvtaRbUUodnfPoEeHiL5dT
         NFXwh1te44TM7Cu41dtmn8snwcvC3i/F+pG2NyKbi4xFM/AnhPSv9odPazxfIl+XJzPU
         wLyLIWRVqFJWGGdJGHmIU/GiWrccGv4Uw7tVk3T90uEUGidXZJz1LNaXC6Cx/fYg73KD
         Ut7PIiIHnPeQwDCjxEEvqBzehTVV+WzRqzqOS0iSAl27l99zVSu6rhxg8sS/V/OdXsVG
         fF6Ep2Dm5WC8t8qsLWWhH+mKA5rr22udQf1FQsaRLO+SkrNZx1mR3Z8K3vEsirGDKZtl
         PUMA==
X-Gm-Message-State: AOJu0YyH15c0+BO8DnVXHGo3gGG/1wYD2fGSaiCTEHGb384tLjoyEIr+
	YWqk8x+8ce8Vigb/QIoCTrEp0JZIZpn4wlSH0NDUkhudEJJoipKgdG/x2Pe7Zbqh22U9VAbCMeP
	3xYrhDEh8c6u+Pw9L9EKk3v4TNErxxJgrV6Pq7SQ3
X-Google-Smtp-Source: AGHT+IHgHjelVczQdsQJHfOi+BduojPTMd0yAQQoHhGltrn5IT1qObxSvvmKf8Ld4qPGQbYqZLzQM/v1rAfdW4BGy+Q=
X-Received: by 2002:a81:9e0b:0:b0:62f:945a:7bb1 with SMTP id
 00721157ae682-6429c6dae8cmr111474057b3.42.1719387071005; Wed, 26 Jun 2024
 00:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Wed, 26 Jun 2024 15:29:41 +0800
Message-ID: <CAFrM9zur6bHTXJha-=Jyq-qYiZGodD-8hf2vMFfjKrnF+ir-Wg@mail.gmail.com>
Subject: A question about BTF naming convention
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

This is my first time to ask questions in this mailing list. I'm the
author of https://github.com/tw4452852/zbpf which is a framework to
write BPF programs with Zig toolchain.
During the development, as the BTF is totally generated by the Zig
toolchain, some naming conventions will make the BTF verifier refuse
to load.
Right now I have to patch the libbpf to do some fixup before loading
into the kernel
(https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-for-invalid-BTF-info-generated-by-Zig.patch).
Even though this just work-around the issue, I'm still curious about
the current naming sanitation, I want to know some background about
it.
If possible, could we relax this to accept more languages (like Zig)
to write BPF programs? Thanks in advance.

For reference, here the BTF generated by Zig for this program
(https://github.com/tw4452852/zbpf/blob/main/samples/perf_event.zig)

[1] PTR '*[4]u8' type_id=3
[2] INT 'u8' size=1 bits_offset=0 nr_bits=8 encoding=(none)
[3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=4
[4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[5] PTR '*u32' type_id=6
[6] INT 'u32' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[7] STRUCT 'map.Map.Def' size=24 vlen=3
        'type' type_id=1 bits_offset=0
        'key' type_id=5 bits_offset=64
        'value' type_id=5 bits_offset=128
[8] VAR 'events' type_id=7, linkage=global
[9] PTR '*[2]u8' type_id=10
[10] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=2
[11] PTR '*[1]u8' type_id=12
[12] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
[13] STRUCT 'map.Map.Def' size=32 vlen=4
        'type' type_id=9 bits_offset=0
        'key' type_id=5 bits_offset=64
        'value' type_id=5 bits_offset=128
        'max_entries' type_id=11 bits_offset=192
[14] VAR 'my_pid' type_id=13, linkage=global
[15] FUNC_PROTO '(anon)' ret_type_id=16 vlen=1
        '(anon)' type_id=17
[16] INT 'c_int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[17] PTR '*perf_event.test_perf_event_array__opaque_478' type_id=18
[18] STRUCT 'perf_event.test_perf_event_array__opaque_478' size=0 vlen=0
[19] FUNC 'test_perf_event_array' type_id=15 linkage=global
[20] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
        '(anon)' type_id=21
[21] INT 'usize' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[22] FUNC 'getauxvalImpl' type_id=20 linkage=global
[23] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=3
[24] VAR '_license' type_id=23, linkage=global
[25] DATASEC '.maps' size=0 vlen=2
        type_id=8 offset=0 size=24 (VAR 'events')
        type_id=14 offset=0 size=32 (VAR 'my_pid')
[26] DATASEC 'license' size=0 vlen=1
        type_id=24 offset=0 size=4 (VAR '_license')


Regards.

