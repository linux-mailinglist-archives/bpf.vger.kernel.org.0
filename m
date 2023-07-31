Return-Path: <bpf+bounces-6407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7409E768EA9
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070DD28168A
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181E612D;
	Mon, 31 Jul 2023 07:27:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBF01FDA
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:27:24 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D2558A
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 00:27:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe07f0636bso6642990e87.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690788439; x=1691393239;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6jxr+Paf/a8UqAyEVDhqQSHA5jQ+PC3SvxEo5GaFhM=;
        b=AB8O1HDJ9Cx3twLOTmJ6TUlyrJyTZFp7TIxybg7qc1rniE8GpbcoL4m9lFcZyurDHC
         WAZofQhz+/+Z+5oPWFlMxiMRbdT9n6M3cL4VLgCEy7jn5tjuarX98qfl7s05E6q0T3Ce
         up+bENO6WgnuxxXp9uUgWpPJouuQkEK6ClpSvD6sdvmX1fU/0VQul/j2JAJqNc6LXlKx
         +cyJYAWIZBCFiLQ4l5nDtaF31yFShCGF/0M9a54O8Febdqap1xSipp9LO+59yuoCbZx2
         tR5CLgYIq9c7y5yiewyNsdyTCu+yPpffdeqn6H3tWrmjQbSjk5duAOImOKK0ZT3orMsX
         KasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690788439; x=1691393239;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6jxr+Paf/a8UqAyEVDhqQSHA5jQ+PC3SvxEo5GaFhM=;
        b=ZrEZXtG/LffQcu/WFa5luO/U51FPT0iC1MnD2zxmgKTgaFvFeD02r+2Dm9quMLuCS2
         TSwzpQT3E0zCjwYAzFOckUFuqR3d9lwV3lSCTwhBiBLjFpfuW+SKMLf5EWEyTbPTR0i2
         5ghNJ4Zyp9Zo6i5Q4S9YQWSDTbdLp2JikvNBRdXO0Sqo2jpSljfoPWNULPKWu4rzI7f2
         VKEXAkCsUkfjxl1RwYU/WnNInXuqGNLwqNtR3/cmjpbjQwFg41Bl5dan2U2yjgG3eTmr
         6NP4OQRSeCpU0sTHSHSDFoVNSQcKwYEbuYkMhP0L5e9t0HTrVoUIJvKdcFgRlnRotlS7
         cgpg==
X-Gm-Message-State: ABy/qLbvmkE4UHHjjDlgFxRUUNlc6+bqdWgWY3EAbZ3u9N36fPUfNn2h
	9lhaHskblzCyQ238VzJVGcTyEA==
X-Google-Smtp-Source: APBJJlFZhomd8eV604yZpQyZKiQJi8OGu69Xu9Z05CLBmr3gbQEakkyIwpAUsCMiXZtuPjzSCulqXg==
X-Received: by 2002:a2e:3e17:0:b0:2b6:e2cd:20f5 with SMTP id l23-20020a2e3e17000000b002b6e2cd20f5mr6366662lja.9.1690788439102;
        Mon, 31 Jul 2023 00:27:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x20-20020a1c7c14000000b003fc01f7b415sm13355283wmc.39.2023.07.31.00.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:27:18 -0700 (PDT)
Date: Mon, 31 Jul 2023 10:27:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: thinker.li@gmail.com
Cc: bpf@vger.kernel.org
Subject: [bug report] selftests/bpf: Verify that the cgroup_skb filters
 receive expected packets.
Message-ID: <cafd6585-d5a2-4096-b94f-7556f5aa7737@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Kui-Feng Lee,

The patch 539c7e67aa4a: "selftests/bpf: Verify that the cgroup_skb
filters receive expected packets." from Jun 23, 2023 (linux-next),
leads to the following Smatch static checker warning:

	./tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c:116 connect_client_server_v6()
	warn: unsigned 'addr.sin6_port' is never less than zero.

./tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
    107 static int connect_client_server_v6(int client_fd, int listen_fd)
    108 {
    109         struct sockaddr_in6 addr = {
    110                 .sin6_family = AF_INET6,
    111                 .sin6_addr = IN6ADDR_LOOPBACK_INIT,
    112         };
    113         int err;
    114 
    115         addr.sin6_port = htons(get_sock_port_v6(listen_fd));
--> 116         if (addr.sin6_port < 0)
                    ^^^^^^^^^^^^^^^^^^
Impossible and also it doesn't make sense to compare network endian data
with < 0.

    117                 return -1;
    118 
    119         err = connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
    120         if (err < 0) {
    121                 perror("connect");
    122                 return -1;
    123         }
    124 
    125         return 0;
    126 }

regards,
dan carpenter

