Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96992E53D6
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 20:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfJYSjG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 14:39:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38777 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfJYSjF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 14:39:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so1701405plq.5
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0mBz0irOSbKoy/XDaINS4+iJlxSn8cKAvdTj8tcbPwg=;
        b=cgIYENo7k5APpE4IBq2PiItOzWXffLlUY8LSgRGLUorI4ruDRnI2x+prBoQ920Rpvv
         DOxJmENbvzdCfdXjW+f++tAh6PNP+6RWJ94dkoJaZ/8C2YKdX29zHHCD/PLLPTCJl26D
         H7HlHwAcj6BzLj2IZ9F5r+fma9mfppYOuierYmydVDLX4COQJlLavRFApTuOF23+lxV/
         jR3keN9q7Cl3ZHhIALMAuUIx0GjrhCuo5p6UlkCaDo2Nb+c+cTITcOtAZzg/8Yib+wqz
         dlXLbGgWJTaTPgnKsHjIHeBpWQfUH1rbBbsUxFB7G1LFiay6RKdAzvCRJdfkV1u9VYwr
         EbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0mBz0irOSbKoy/XDaINS4+iJlxSn8cKAvdTj8tcbPwg=;
        b=hPonwBua6fjhvMaNX94LH3NKRVxhvDWqv2uZ08wq1yNwWSbIlIFBg44WI0EHR94BMW
         s82b2Fr7VqOAFub9XBWCX7R8bZk/CSlVtmedNyq5N5EKMWVDOiBwFEUPrS4VT29QaWUJ
         /O71Q4AErrZ+uVaKKDHnAoJfBhytHx8s1sqpHz/7CPeJ603uo0CC5qiHG4fcd8CwZIbB
         jRagRS02gRBIKJoeQHa0nAvFZyU5KaZDr9L7Sk8XBjklnv2c8A4EBJ+llnLT0ScaI0eE
         EOx/MKqzrJKZy/3BD/6UpkIVMlg+i/S+vxU51yZN08D3ZFuqJqHSDF9tkhJh09nJsNU0
         O2ag==
X-Gm-Message-State: APjAAAVfQgwROrb1LDwsChq8C5p/XrIVGgmSTMIhk4sbmIPV0a63tSvs
        f/yiE8GBAvn2o6fQwsoki7Rh1w==
X-Google-Smtp-Source: APXvYqzUjPgweqD1AiuoDmGlwKdY7a5li63Uz8In6IeLq1VbqLgnBcEFoaS/yqyK6DuP5e0yapaHag==
X-Received: by 2002:a17:902:d201:: with SMTP id t1mr5539900ply.212.1572028745119;
        Fri, 25 Oct 2019 11:39:05 -0700 (PDT)
Received: from cakuba.hsd1.ca.comcast.net (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id a14sm2786692pgh.80.2019.10.25.11.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 11:39:04 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:39:01 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] bpftool: Allow to read btf as raw data
Message-ID: <20191025113901.5a7e121e@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20191024133025.10691-1-jolsa@kernel.org>
References: <20191024133025.10691-1-jolsa@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Oct 2019 15:30:25 +0200, Jiri Olsa wrote:
> The bpftool interface stays the same, but now it's possible
> to run it over BTF raw data, like:
> 
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux
>   [1] INT '(anon)' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>   [2] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>   [3] CONST '(anon)' type_id=2
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
