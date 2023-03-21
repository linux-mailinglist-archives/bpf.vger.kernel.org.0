Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872E56C3DA3
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCUWUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUWUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 18:20:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4672278D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:20:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ja10so17570845plb.5
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679437216;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMH44KI/fbEUbSCIZfFWq+uDSd7hFCwhzQ8aehFe8Ew=;
        b=GRVIpwH1M+5iUVsBUI24RSozT5F5zUgx9OMlHA+EZZ2V9rwCkL5ftbBpoAw9+gBB+b
         /MlFg7yjscUyzLjqcMthuIK8TkGuXB0jlGlxaTv7mHsPBsHMADFz7YWWM66PcYjJ+R7w
         VKqVXy8eUfc7UwFsqbt9GZT0Qa67dqiwpMz/NwaHGdGhkEALzCnyEyUcoYShodMWu48m
         HPXN72vj2JnXo5FWBQkKwg0L1FtvxJfkMFd4eJq92oqiwGdQv+2GrwAgIQfqUgRt+5nz
         xwi++L58PjeqXOTR2hPN7Hwvl/dzp9ZjXVuMYjfCd9iAxqofQgaKFT2/wh/rb6i1g8p1
         iGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437216;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fMH44KI/fbEUbSCIZfFWq+uDSd7hFCwhzQ8aehFe8Ew=;
        b=mVfcFEy7ICTjMBWBDtA91i1Rwt5yq45i80ABc0/SeEgckRQzJb8ADv6I46Xiaa0S/M
         rPO5S+z9GMPE+8uuSD7cY4CRhxGBhYaCMaJxnhSIJj/QlkAWVIt4P46lMzuBdIV3VW0g
         3BOBqhYyBSChgkOHWHw/hRKVrd4xoUJqhrHF0vWcBJn3YW/EYmQn8heoW9yW3BMrqffC
         oJFY8lsW/FA77gKpS3HrdIQ7Dui2YaovHGS6zD7Gz6YVzeFMQjtlyntmi6a+ZbhanLAd
         Sj8vKIV1Idaam51wjbmi5WwzoL9T7WLn+jpSkhWc/pB7UnfMBjGI20c/ztZKyOBjVHjc
         zKEA==
X-Gm-Message-State: AO0yUKUHuOH5OMc3XrFp6V7q21NJSSrwo4WpT16cCmGqZxPdHmiChEKl
        /vtbj5gpPCJoX5Vj7Dom97pblp8iG4I=
X-Google-Smtp-Source: AK7set8NUJMGX5gAKMscnPZz8fCF7k33XKqEdvhksBSA1L6JVNMgxgcMieHnwn6yqizKPXcEfcP6tQ==
X-Received: by 2002:a17:902:ec8c:b0:19d:138b:7c4a with SMTP id x12-20020a170902ec8c00b0019d138b7c4amr724407plg.3.1679437216281;
        Tue, 21 Mar 2023 15:20:16 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b0019abd4ddbf2sm9199089plr.179.2023.03.21.15.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:20:15 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:20:14 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <641a2d9e8a447_80a2420820@john.notmuch>
In-Reply-To: <20230321193354.10445-2-daniel@iogearbox.net>
References: <20230321193354.10445-1-daniel@iogearbox.net>
 <20230321193354.10445-2-daniel@iogearbox.net>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: Check when bounds are not in
 the 32-bit range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> Add cases to check if bound is updated correctly when 64-bit value is
> not in the 32-bit range.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/testing/selftests/bpf/verifier/bounds.c | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
