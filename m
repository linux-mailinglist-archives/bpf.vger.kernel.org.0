Return-Path: <bpf+bounces-36870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1885F94E6FE
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 08:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82C51F23AEB
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E1215445E;
	Mon, 12 Aug 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZMHpciV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51214F138
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 06:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445007; cv=none; b=QnGcMCw51vYYAC3ZU2SHEPgQ2PlewW9G6NoROcxYKdPwgJckIJDpPlx+RjemzBmmJCSoTS37jylBaLKzZv0DA6kHA5OBpE/bNXK40NTlb8XSo6GDqLKmItc2gyu7RMMuhLcnLI0WNDrbDogUnitN+XyAEvGlY4vLqKEatYx+G8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445007; c=relaxed/simple;
	bh=AOfwNoLwJjtSaI2BZZALIFqSghZz9QsLS3wa8w0A6pk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D97vFRyKKVu8AU7mYeLRcG+zhabdILeiK7EwdEv4z8QxJmSKwV9+Pm/NWza+6GjCClYv9LPiW2rpGKT/Kqu+CdqYfr3SZfTsojlgektbocbk2KiYZ0N+VGNe1GWGpmQkvIxgdMszF/41b93RgNUj0R+ybmz3Wlo5+R3WBwPXecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FZMHpciV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a83a968ddso364410266b.0
        for <bpf@vger.kernel.org>; Sun, 11 Aug 2024 23:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723445004; x=1724049804; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufhnVI5Mq42YoKpIj2A75n0g+01pdIXjFsXMmT6YuqE=;
        b=FZMHpciVYhfYuY8PY/KTQXLMKN508a3tgB2NmoCRyeY8VeUDgzc+mgS0LHhd1s//vL
         f8v07+xo/UhX6DqtA1z2TcFIOWX3utjccnGjWKjt8VPGPqCnAKvWXCNH/IPsYmSGRmZe
         9JYMTtz1wulOMncAvfnM0NX+n8UI1/cFRWuFoslGWUnZMQkPLO96odPdnSRY/cShdVXJ
         Mfzr0t32xXTQbC5fst/B2DeeXlsbVn31yykeWyZ0U0XQgbEDxGJI0cLB2pnPWc+aLS6G
         mNZCOeWb4zFuxisHCK9rJpQGLHQcqdXf6Xum+H3bfOZz1P2kBZTBqx3nN+NtA6oazK2X
         I9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723445004; x=1724049804;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufhnVI5Mq42YoKpIj2A75n0g+01pdIXjFsXMmT6YuqE=;
        b=EyFP5bszEleXrf5ZEJq5jR1V69NXoQz1KmXdvm76CFmQmoMHrJ+SUN6AFbDqz4gpkK
         a79F6LhY2cRx2uDr6c3nc4y9WlLpxpBoYMhYSK767EWm+aAKv0jZB8tIXIuUttP+KGHj
         eL7i/sPo6jmUFwnXEWLoFrArGstFIUVlwoTLynJuhAuCsaX76auEYwHfYRHLbiTfy/yM
         Utmt0vsm/pwbEincUAXpVM3Qp/BUKDqgTuMmef9tv401lKgVZ1nMe7rkQUhxX7evZ6Iw
         HX2cIASrpnXbMiLumptdrA22XmbIuqJApRxOYw8LHqANhD3Tozi+XEJemy4TVEhMaoDO
         DhdA==
X-Gm-Message-State: AOJu0YzaTn7o5sOuKePJy3YdRm/FnmIquDAzl1zSmPmmxzN+ifXBrKoF
	5hQ+JuH4DtxeEhkr1vpVsnaa0AeiPCw+tR5wIZrTUCqcbpPFeBggHw5aptcSuIOgRDyrFuN8RQS
	r
X-Google-Smtp-Source: AGHT+IE3cXreNWGEzURPfFPCiZu3YeHI1n6JrbP6uFwFOgZVwuz15JxXvN8ENsxjHSiM4t+c8TlMBA==
X-Received: by 2002:a17:907:608f:b0:a72:8066:c76f with SMTP id a640c23a62f3a-a80aa67c267mr607897966b.63.1723445004033;
        Sun, 11 Aug 2024 23:43:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce50sm201928466b.129.2024.08.11.23.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:43:23 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:43:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [bug report] bpftool: Use syscall/loader program in "prog load" and
 "gen skeleton" command.
Message-ID: <d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Alexei Starovoitov,

Commit d510296d331a ("bpftool: Use syscall/loader program in "prog
load" and "gen skeleton" command.") from May 13, 2021 (linux-next),
leads to the following Smatch static checker warning:

	./tools/bpf/bpftool/prog.c:1925 do_loader()
	warn: missing error code here? 'bpf_object__open_file()' failed. 'err' = '0'

./tools/bpf/bpftool/prog.c
    1906 static int do_loader(int argc, char **argv)
    1907 {
    1908         DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts);
    1909         DECLARE_LIBBPF_OPTS(gen_loader_opts, gen);
    1910         struct bpf_object *obj;
    1911         const char *file;
    1912         int err = 0;
    1913 
    1914         if (!REQ_ARGS(1))
    1915                 return -1;
    1916         file = GET_ARG();
    1917 
    1918         if (verifier_logs)
    1919                 /* log_level1 + log_level2 + stats, but not stable UAPI */
    1920                 open_opts.kernel_log_level = 1 + 2 + 4;
    1921 
    1922         obj = bpf_object__open_file(file, &open_opts);
    1923         if (!obj) {
    1924                 p_err("failed to open object file");
--> 1925                 goto err_close_obj;

set the error code?

    1926         }
    1927 
    1928         err = bpf_object__gen_loader(obj, &gen);
    1929         if (err)
    1930                 goto err_close_obj;
    1931 
    1932         err = bpf_object__load(obj);
    1933         if (err) {
    1934                 p_err("failed to load object file");
    1935                 goto err_close_obj;
    1936         }
    1937 
    1938         if (verifier_logs) {
    1939                 struct dump_data dd = {};
    1940 
    1941                 kernel_syms_load(&dd);
    1942                 dump_xlated_plain(&dd, (void *)gen.insns, gen.insns_sz, false, false);
    1943                 kernel_syms_destroy(&dd);
    1944         }
    1945         err = try_loader(&gen);
    1946 err_close_obj:
    1947         bpf_object__close(obj);
    1948         return err;
    1949 }

regards,
dan carpenter

