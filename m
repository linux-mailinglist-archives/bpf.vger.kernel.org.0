Return-Path: <bpf+bounces-55618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF9A83701
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 05:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA741B644E0
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D31EB1B9;
	Thu, 10 Apr 2025 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7VxUIlR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACB1E9B23
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744254359; cv=none; b=sVrszfyTt8uXoadpg9VfRak43CobMHY+MSAyP3XmiUdf5UnLvI6EzBCWrMdDyH02jCEWTa0NWC//te0wop+GdnTOa7WAUcRWpo64+TzhdmpyuDKOOAjC9n3sQYONb6AuX4cWW0dLWsRVJIyPhptvEczs4JUntAOg94Tt/xWqmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744254359; c=relaxed/simple;
	bh=jdw0VHJYs1n/HZ+tnCJemIUc9gDmTNU9uf86mpebvw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lROPJ44Gc8FFfV6CZ/sUl7RqO4H7mlvlX16kqHLpX6McyBNuP80ZksMizxHEMf0ZkJJe1E4iNwbmRg1IH9lz1vmaBoHNXUGY6BVqYrSpNklM063JaFYFMbhqRCAH4ZvYobgrCQvPIy/k6xSB52b3xq8QEXpw9TyQ7p4DU/uWRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7VxUIlR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so2731935e9.0
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 20:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744254356; x=1744859156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwAw1TsBii83kk4lUF4LH39iDyNW1AnbB4bEDQwJ2bM=;
        b=B7VxUIlRv+bP3xurK1gmAygPyyyr2aVY4JjO7IaEVZQfb07+smvtjsfCIdmPSpeMQf
         M12aXSuQ0sqDZ40H254WC1eUGlqhzOnp1j8DG6GNxlOz7DgMN6VGX5vUwDer1SKgt9Lo
         e/tm/7OLm0TJjNIYbIeIYpd/EdbrzBwliyJaGrzKQFyYain1x5VJHICdQKRoEPIC5URF
         a0tLZpxmv9NmmKPupcZdDNOnbrc2JKBy7UKo62cxpcRpPNWRHd0fQYkL5zF9fGYejh4h
         ws3HRIsn7Ve8Q/7gdhMVZoUzKe2Q3eDne4SCFdRtqBNDEnwcdxRQk36RQBolmujZYc9F
         88Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744254356; x=1744859156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwAw1TsBii83kk4lUF4LH39iDyNW1AnbB4bEDQwJ2bM=;
        b=AtylyMIDAOW957aA5IfE5qacG5xeYF2wYInY78JX/b8mHWXsBhlMgjbuip4UsKTkH5
         TG1J7ZYwXr8DY1T7S0KndF+qwM2iDPU/DALAJqlKAbJh/QVQa5GFgxDqpEnVGwd8AvSF
         HR0FQVqf1aY/Gf/30EmSW9QBHRDDBhJvLXdUj/4Kvu7kBm9PcjxcQtNwfbtrlc5gdtrC
         0KvU1sFcPjdQnTqLiPFMTL1JxrxRnRNljuWq5Ck6A75d8j6VnK/HrYLRUkK3Kt+dC3IB
         ZwKci7OmolKCoUbGGxJFTqhjdolzAackXi74wBdLv54pepyy8uO1mjZUDSWzFD4mk6dZ
         uxng==
X-Gm-Message-State: AOJu0Yx2g9++K0JZwkch5fFjvM6jtsGAItZ6KgVYPv1sUT7kCLODD6q2
	PET6SCWRFFgpXhY+FAEUtZABOXIUTnNvwkQ6a4aPgzAozQlzNDiM7avAWGDR0uAvuNT6UI5mXs2
	N+ed09kmWC9Mnmk+JUnxKYsnhbpSDoKl/
X-Gm-Gg: ASbGnctYZwzpA3RO9ZeOSLbXD7onJ0t890p0HR4fBiyenxV7iupQiUhOOONDz4AUadd
	PVWPglRmH6CcfjOVLyRv0rq/yxrzPLpdjJQJELNzd7Dtx7uPN0shFjba1UH/BEq5WpIn5pe1gXx
	AEF6NCx23hCWV8O1+KkXxmsY2d62hRQdX7kbfcHQ==
X-Google-Smtp-Source: AGHT+IGOLtnyCGvqqUynLv1E7wmjmbpCw4uoL585byCKRKMzXz9+YzNzIsmNXX7Xnt2IQbyjhKrW7qQn9crn7789r4I=
X-Received: by 2002:a05:6000:240d:b0:38f:3224:65ff with SMTP id
 ffacd0b85a97d-39d8f46566cmr760866f8f.5.1744254355680; Wed, 09 Apr 2025
 20:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_aSOFIJkhq5wcye@bkammerd-mobl>
In-Reply-To: <Z_aSOFIJkhq5wcye@bkammerd-mobl>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Apr 2025 20:05:44 -0700
X-Gm-Features: ATxdqUGXlytnb8gyazZjB0BwCwepknPN3DUUxt5Rg02o_OfYBvQZMbkC_o0k4XE
Message-ID: <CAADnVQJkMG8-tEdNLxkMk2hDokrXt+iEgrMWZeizQ4S-GXaRpA@mail.gmail.com>
Subject: Re: [PATCH RESEND] bpf: fix possible endless loop in BPF map iteration
To: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 8:34=E2=80=AFAM Brandon Kammerdiener
<brandon.kammerdiener@intel.com> wrote:
>
> This patch fixes an endless loop condition that can occur in
> bpf_for_each_hash_elem, causing the core to softlock. My understanding is
> that a combination of RCU list deletion and insertion introduces the new
> element after the iteration cursor and that there is a chance that an RCU
> reader may in fact use this new element in iteration. The patch uses a
> _safe variant of the macro which gets the next element to iterate before
> executing the loop body for the current element. The following simple BPF
> program can be used to reproduce the issue:
>
>     #include "vmlinux.h"
>     #include <bpf/bpf_helpers.h>
>     #include <bpf/bpf_tracing.h>
>
>     #define N (64)
>
>     struct {
>         __uint(type,        BPF_MAP_TYPE_HASH);
>         __uint(max_entries, N);
>         __type(key,         __u64);
>         __type(value,       __u64);
>     } map SEC(".maps");
>
>     static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *ar=
g) {
>         bpf_map_delete_elem(map, key);
>         bpf_map_update_elem(map, key, value, 0);
>         return 0;
>     }
>
>     SEC("uprobe//proc/self/exe:test")
>     int BPF_PROG(test) {
>         __u64 i;
>
>         bpf_for(i, 0, N) {
>             bpf_map_update_elem(&map, &i, &i, 0);
>         }
>
>         bpf_for_each_map_elem(&map, cb, NULL, 0);
>
>         return 0;
>     }
>
>     char LICENSE[] SEC("license") =3D "GPL";
>
> Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
>
> ---
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 5a5adc66b8e2..92b606d60020 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *=
map, bpf_callback_t callback_
>                 b =3D &htab->buckets[i];
>                 rcu_read_lock();
>                 head =3D &b->head;
> -               hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) =
{
> +               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node)=
 {

The patch doesn't apply. It's white space damaged.
Please see Documentation/process/submitting-patches.rst

