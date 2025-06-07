Return-Path: <bpf+bounces-59993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30280AD0C1B
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3BB3B0B57
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B4920C47B;
	Sat,  7 Jun 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPVF1F0m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926D1C5F2C;
	Sat,  7 Jun 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749288440; cv=none; b=TY3Ym4qXNtNV2dd1Xcu/tB427URagWpL8hMFABNGroiNrz3LcCiVxpC+Cue/4soCsfE+6EwlF0voy7MJ/MwnUzGDsrrGzEBc3/QdDgwEnFI7ObFF9yhZLTsXbVZHOnkSHu3CYjyd0j3nKkyIlHHKhC+OyhVjjRHRAWhYfu03i58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749288440; c=relaxed/simple;
	bh=EimdEfbxy9f3n4pqz8glXweRRH2yRxI2qczGEFcb/9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECeJbxFudNRHplvfPZkSS9GszWE/k09uFltQmgAPmAlwGQMW7usHN2kqFEGWl5yGAvm8ELETcn7l9lQXD3LUDZHE5H8Y8RLasGRBHH0TO9saEjTco5fEm4XIR414tBggZokLali3N31FbvlmDsbdm4GzSsTmo8JTFWnNyjjWwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPVF1F0m; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234ae2bf851so4409945ad.1;
        Sat, 07 Jun 2025 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749288437; x=1749893237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ618K/9B+ws58WKtKVcQe8gIJGwOodDGL8PPYqV65Q=;
        b=NPVF1F0mQJqunwR8VMd+RjWj/q5lCFhFItWAUFMwNF5QST5fdbkTNiy1ZE/HiNvlqL
         f0SoAF7UX0H0Uh/srvKgHwID59HtjRxgpvSFbVnkX6azJ40yUoqr07uYBe2gkj7Gq/Ly
         Zc0FDO0ohz6N4PUzG15bGlEH/tQXtLC3vHXJUBXs+nAxfLepEmq0jNNXLZupV/SiWuQ0
         pHYgDUGCKhmiXvs13RS4fVHJf6RGyPl9gjSDHCLEgLNel61tyte3TyMrJlBsbk03GJYZ
         zJ96T5ay7s2smVR+9OIgYhT6lJE3LkVxp9vB04h1R2vLeF7E6S+9AIiUs1LhLdQvcoJ3
         e0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749288437; x=1749893237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ618K/9B+ws58WKtKVcQe8gIJGwOodDGL8PPYqV65Q=;
        b=aBG4UQNUy9DzOyTjpttm1sOkb0YUjlfpB1jSmj0C36iIKOLHxlS6m2M+nIXZ5FGEAL
         HT3CyGpwGB12NL9C643jBjEP4ilOx4yP1AO1vS3iM++WgdRMqRS81oiGY1LRYasXrZ9y
         eiZhKhQ5doruBWBlYNxrqX9I9ljN+QORjZrhEZ2dkjZtW2nItiIiAJXT2cxQpVv8EzSx
         MOEMUEdexClGkNtZTmUyzyYKEpKeiF9hfYGq6Xep6LQY3FkembginHaLymdARuYIn8pO
         uVi3I4zEtxNiTdQdIbOgUuA8Kkzek3PQNFny77vFgPvVoISwginTn2FCe9+3w9GdkYcG
         dOmw==
X-Forwarded-Encrypted: i=1; AJvYcCUYagH7yVgeRdP0ClEM3HIRsJcNvyr0hEysBjuewX3ZIJYcBD4N5Abso6KI52yUX8nse83wEe/Tljg=@vger.kernel.org, AJvYcCXMSMagOVBiEOwSWXzzR47x2Wkd1vZkVPDfbNghjPcLC7AprMaxtshEe8S78raN14Z/WE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLncso1TxcKtspmWLIeqA0CcWn4ec1gWAFSfYPVIz72l7ffafw
	AFa1TtAkdYnD7K0yYKgdZN5QQAXAsNOyrFxDsc82i9re/xdoADkgSxNvifxo7uUPIntj7sMO7vK
	TnCZtFaMCHFE4JkvFP8Z66jmpEf/c6Bk=
X-Gm-Gg: ASbGnctk5n7K9En/xI4ZI7sd4DxFfXhyoTSNX7+H5QOSpg+lSTtBi4LMWuPHg3Wnb9A
	N1YY3EGY7tlGIuK6A+FySxZr/vkPLy/Zy+axiE9jOXNK7vVz4q++Aw14MqrljoYzZmID0kMJ399
	D/xjtH/JBmK4EIhvA8Ajcc/utkJ6/pEf3RjOsNJvb9uWrfRJB7jNJ52w==
X-Google-Smtp-Source: AGHT+IGeYeKXl3hgG+Fp/G3HE7APEoKAwmE4M3Tyz0AMmqc1zE6hRZt1BFPjsCs2HVZDcx8eLr2OyyXzRJWzUum43vg=
X-Received: by 2002:a17:90b:3d04:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-3134e418de8mr2864012a91.7.1749288436994; Sat, 07 Jun 2025
 02:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214840.3165754-1-andrii@kernel.org>
In-Reply-To: <20250606214840.3165754-1-andrii@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 7 Jun 2025 11:27:04 +0200
X-Gm-Features: AX0GCFvji-yOOYaLkUD3HloEKDD6XOA1rmp4GBK4VajWZsqIV0W1a5ingTaeHno
Message-ID: <CANiq72kDA3MPpjMzX+LutOoLgKqm9uz8xAT_-iBzhR3pFC+L_Q@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: ignore compile_commands.json globally
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org, masahiroy@kernel.org, ojeda@kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	linux-pm@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 11:48=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> compile_commands.json can be used with clangd to enable language server
> protocol-based assistance. For kernel itself this can be built with
> scripts/gen_compile_commands.py, but other projects (e.g., libbpf, or
> BPF selftests) can benefit from their own compilation database file,
> which can be generated successfully using external tools, like bear [0].
>
> So, instead of adding compile_commands.json to .gitignore in respective
> individual projects, let's just ignore it globally anywhere in Linux repo=
.
>
> While at it, remove exactly such a local .gitignore rule under
> tools/power/cpupower.
>
>   [0] https://github.com/rizsotto/Bear
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

