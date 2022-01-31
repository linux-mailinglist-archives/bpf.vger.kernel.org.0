Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CB4A47DA
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 14:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiAaNPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 08:15:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234808AbiAaNPP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 Jan 2022 08:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643634914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FeGLRifRzLE6TznX8Ku8/uOBOutTsIkvk9v4ykgx0E=;
        b=dCGF+7RbscA2RVTZ4Uiv/bNNf/9PEYENOt8LzloDFQVjnpWtH7RVBjMhJyKDciRxkkR9UH
        zvpgzvBX0CcwrEP56yyKhb00kUM/UFm94BIaz4CC7JvANKmSCBal1izjN5vlLLYcieLBPV
        saPlYaExox4gEoKP0fZhtgV2fr+EEhs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-A7f_1vv2MbuhLc0PyIe2Pw-1; Mon, 31 Jan 2022 08:15:13 -0500
X-MC-Unique: A7f_1vv2MbuhLc0PyIe2Pw-1
Received: by mail-ot1-f72.google.com with SMTP id h36-20020a9d2f27000000b0059e33f1f8a0so7953162otb.19
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 05:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4FeGLRifRzLE6TznX8Ku8/uOBOutTsIkvk9v4ykgx0E=;
        b=ZA860ZDDUTjyGYOO0eVjVwzSYW4kKEOEFYjn9jHbUAOOj9FSkSd0vr04pSw8+v/sUp
         rEJm4JypR/WNkOAPPDz7yJhQDJnRwFU5jGXHGiauMrtroIvWesVV28EkXypkPJ5a/+3/
         VoZiD5cLmEWsXOjwOo6dtal1uFfMO+Qpizry51xC7tcpxwT01qyR4KZNd7dj+qEUCmFo
         az4Jd/11xd2FjndjrvII/wNMQrOiSwopowxx9FWJg0QXT2PDE4bRi4JCgd7Xax02XtOU
         j6hivq/krk7+7Oz5rmWbe5/vxpotoG79Nd1FFiOm7Pg5P8NdDfed1yjFIpkO2PXIXKFL
         O+yQ==
X-Gm-Message-State: AOAM532KJS0PSuEWfyqZ45ywpDAA2JrjRsqxae1bStg+C5rAbboxLE2q
        ZD1uAnnHUK0SmUP3uaO82grIfrXEMk6rpKXLSmRcwJzK9RX+wtcYY9v6y/fxeyUjD5qr0M7FU0+
        Rkr4xYoJW1X0i
X-Received: by 2002:a05:6808:23c6:: with SMTP id bq6mr17754656oib.99.1643634912235;
        Mon, 31 Jan 2022 05:15:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg+PlgnvIqsLU9wdXdToRYaNCz/5k5B8bAtO1B3Ld/EJlpN9xGPW04bWDX+KnYUCyo0PUyZg==
X-Received: by 2002:a05:6808:23c6:: with SMTP id bq6mr17754636oib.99.1643634911837;
        Mon, 31 Jan 2022 05:15:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e5sm13714981oti.59.2022.01.31.05.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:15:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 87CF81806B4; Mon, 31 Jan 2022 14:15:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [RFC] failing selftests/bpf/test_offload.py
In-Reply-To: <20220130225101.47514-1-jolsa@kernel.org>
References: <20220130225101.47514-1-jolsa@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 31 Jan 2022 14:15:07 +0100
Message-ID: <87k0egt5b8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:

> hi,
> I have failing test_offload.py with following output:
>
>   # ./test_offload.py
>   ...
>   Test bpftool bound info reporting (own ns)...
>   FAIL: 3 BPF maps loaded, expected 2
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1177, in <module>
>       check_dev_info(False, "")
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 645, in check_dev_info
>       maps = bpftool_map_list(expected=2, ns=ns)
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 190, in bpftool_map_list
>       fail(True, "%d BPF maps loaded, expected %d" %
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 86, in fail
>       tb = "".join(traceback.extract_stack().format())
>
> it fails to detect maps from bpftool's feature detection,
> that did not make it yet through deferred removal
>
> with the fix below I have this subtest passed, but it fails
> further on:
>
>   # ./test_offload.py
>   ...
>   Test bpftool bound info reporting (own ns)...
>   Test bpftool bound info reporting (other ns)...
>   Test bpftool bound info reporting (remote ns)...
>   Test bpftool bound info reporting (back to own ns)...
>   Test bpftool bound info reporting (removed dev)...
>   Test map update (no flags)...
>   Test map update (exists)...
>   Test map update (noexist)...
>   Test map dump...
>   Test map dump...
>   Traceback (most recent call last):
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 1251, in <module>
>       _, entries = bpftool("map dump id %d" % (m["id"]))
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 169, in bpftool
>       return tool("bpftool", args, {"json":"-p"}, JSON=JSON, ns=ns,
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 155, in tool
>       ret, stdout = cmd(ns + name + " " + params + args,
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 109, in cmd
>       return cmd_result(proc, include_stderr=include_stderr, fail=fail)
>     File "/root/bpf-next/tools/testing/selftests/bpf/./test_offload.py", line 131, in cmd_result
>       raise Exception("Command failed: %s\n%s" % (proc.args, stderr))
>   Exception: Command failed: bpftool -p map dump id 4325
>
> the test seems to expect maps having BTF loaded, which for some reason
> did not happen, so the test fails with bpftool pretty dump fail
>
> the test loads the object with 'ip link ...', which I never touched,
> so I wanted ask first before I dive in, perhaps I miss some setup
>
> thoughts? ;-)

It looks like the test_offload.py has been using 'bpftool -p' since its
inception (in commit: 417ec26477a5 ("selftests/bpf: add offload test
based on netdevsim") introduced in December 2017), so this sounds like a
regression in bpftool?

-Toke

