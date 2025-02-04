Return-Path: <bpf+bounces-50435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AAA2795D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4663916178D
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C25216E3B;
	Tue,  4 Feb 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="C+McU8xz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B34821323A
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738692538; cv=none; b=Mj3jXbIoU8otgaUpAdYJ0R68m115wcx+0EVbGAHAK8uKZIS31Cri9GOU0vo4c+hcDpcgKEqM3OylhppgvviOyxHCnEodecugFs8x4BDQnkagXZxSxp0ftXqee/HSOgEpMyScVFLISSvFpyAxxHZ1/9poBznBdE/iXBL8lbdHBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738692538; c=relaxed/simple;
	bh=4QtXUPLVzWBHsUy3BOe8JATq2e1DL1lYxWRjamn9AUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KaPySw0rIq4UUCHJ3jtIvCxRSbtzc6eIoWIEjMkmKDrQ4RDngOQFVl+q5mdup2/WpYYg8PDV1qwHAvYRJRD6vqYavTwkobG0mczmCNboYap1Q5YZVj9P9YoEED/hI4AHOi9VVUG4y6NwfZmMCvto00W+r9SU8XuDLIdqlPvQgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=C+McU8xz; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ddcff5a823so42359936d6.0
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2025 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738692535; x=1739297335; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lM/+Vy2jano89FeHBX6zK2/0kvlTSUAh6tYJLfudZGk=;
        b=C+McU8xz+R20Vx2OPl1iHoWg5EmQBlWpRK8GU7EpKLtbHyN/T9Mdshdbj9qS/lPfyE
         jMZ9IJ5vg+ZxjRNFpGPIy2deQTYQiemlfpWCiUvkOGwS+CbERAEuc0lSwxVZsB5xbShs
         HVasqWQPvVLOrSx5sXdrZ6Z7gVPlniNEvn03TrImQwsHi31vHtKoAj/Au9r3KRCzyzVL
         ThUAI1jHxMvVUqKk+5WOlOZEt2e9BYxDwGKJs/9SLX0SdJsGZ/s5eguvlc7c6t9I4BcU
         QhMXLDSFlEWBKaUBxpizkftp1pyubSXx524YSNFqdFNrUi+yn3DkzY4+GW5AxcSKUVIZ
         FNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738692535; x=1739297335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lM/+Vy2jano89FeHBX6zK2/0kvlTSUAh6tYJLfudZGk=;
        b=nCg6LU46Y4BZ1p8WS8C1Lg0Adn1f1QH36DH1jdhccnLO3opXd30AWPFV7wojx6IBmK
         V+FSr38pjA5nEWvV6zdgBORdJ5lH4Wpa2JxmD4SVZwZmVX4SjYBwV5Eyvcnffb3K4w5L
         +tRLATYHRXVMOzhjLn7cu+cLAm8jld7QIY6aJSIfgWMOUHCF+0lrPkxJ5ZI1ksv/lBfd
         JbiMPbK5ItAgNhli3vQ6lmwlW4coOF9BpRW8/jY29pzO5dV9UiTs7qks2ol6EBEZpk/c
         mxcpIMlz2fGfA6gFzCq2pZOnbUaIDl8hUXLCPKTOzWgpfvuw7NtkZpC1Z5W2tKaRaAom
         S5BA==
X-Gm-Message-State: AOJu0Yyy/1eKgFlxl6EAlf/jjtaMvW8xQNSlraKPGiD5qBuNakBplQFH
	WWmYNL8BvpjZFbmbnKZz4qGtt7UC7ZK6eNI6ZHqwHMF8O2qFijgyz6nJvmpILs6Vo9gMxdiL3N+
	m
X-Gm-Gg: ASbGncv6DEpVFL31yOVE15fn5EZnv4U3w0TepyBxIqEN0mp3Gr+pjmaliNY/RfCSnRD
	C3cgP0H+r0GUL09p4iOR+IFxOos/DZGCUzPqvEU5syqahsfUp8V+LDQKTGbResUL6Z/NSBI1Gmo
	R0td1pefpygXMG7nVjKI7Dqt65kFbX2tcjDL26mD/8jQ6I5Dyac6s6BQ+zT7yarbssLB8w9X21D
	o+R3WzojoaIoNMFJ3s0nfOv7/jKVeDt6ASd2WjMmm7IexiPcRJCkAN45nSzbI9fDTRMK0b02dP3
	vDM=
X-Google-Smtp-Source: AGHT+IHBng95Quw/VutEKjKeYrYvkEMjYC1cEaE8DfgKbKJM/cXCtvjlwBaF5UJ3rSx1nMIo/Kn0LQ==
X-Received: by 2002:a05:6214:488:b0:6d8:e5f4:b977 with SMTP id 6a1803df08f44-6e243bebffemr386193346d6.5.1738692535026;
        Tue, 04 Feb 2025 10:08:55 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e42b2c79c8sm5593886d6.46.2025.02.04.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:08:54 -0800 (PST)
Date: Tue, 4 Feb 2025 10:08:52 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: kernel-team@cloudflare.com
Subject: handling EINTR from bpf_map_lookup_batch
Message-ID: <Z6JXtA1M5jAZx8xD@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am getting EINTR when trying to use bpf_map_lookup_batch on an
array_of_maps. The error happens when there is a "hole" in the array.
For example, say the outer map has max entries of 256, each inner map
is used for a transport protocol, and I only populated key 6 and
17 for TCP and UDP. Then when I do batch lookup, I always get EINTR.
This so far seems to only happen with array of maps. Does it make
sense to allow skipping to the next key for this map type? Something
like:

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..83915a8059ef 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2027,6 +2027,8 @@ int generic_map_lookup_batch(struct bpf_map *map,
                                         attr->batch.elem_flags);

                if (err == -ENOENT) {
+                       if (IS_FD_ARRAY(map)
+                               goto next_key;
                        if (retry) {
                                retry--;
                                continue;
@@ -2048,6 +2050,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
                        goto free_buf;
                }

+next_key:
                if (!prev_key)
                        prev_key = buf_prevkey;


Also the context about my scenario if anyone is curious: I am trying
to associate each map to a userspace service in a multi tenant
environment. This is an addition to cgroup accounting, in case the
creator cgroup goes away, e.g. systemd service restarts always
recreate cgroups. And we also want to monitor the utilization level of
non-prealloc maps of different tenants. When dealing with inner maps,
it is not always trivial. To connect dots I choose to read these IDs
periodically and link them to the tenant of the outer map, that's
where this EINTR occurred.

best
Yan

