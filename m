Return-Path: <bpf+bounces-100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3D6F7CE9
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263DB280FAA
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD921FB6;
	Fri,  5 May 2023 06:27:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FA156E7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 06:27:02 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FFE9005
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 23:27:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3909756b8b1so474873b6e.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683268020; x=1685860020;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpdYIiJEOfZaZq6e665Bt+hRbgC5rpAPNfKzSP2GfNY=;
        b=IkMDZcOXMBGImxFnJ3bo+L4ou4bXeWlO6kEY1CIIdMvvj6PqDQ+66mBCmbNL9DjCeR
         OSz3oR3rKJkLhmVCON8JXeAeSD51MT9s0ud3fGLyCzY3tN4H3NLWSOqZec/VO+4rNAvM
         DQg7uXOY3G9jO/wbaptQWJs9O8KMZQdFLwufMh0oaSlTm5d4kKoVzXO6rsbsXOgZ9Ogb
         hzby1GWhaX9zqsJdldGdWfsykNAc5uqWUms8zEd4uZM4Re5A1i3uaDYYuTPVaikKzGgz
         P4fPUSDRRWrhnGaB1cztaFou8NfTgc18NOyt9VokkorTKjfcdmdqnLKZyA+dXaLkYnWb
         lczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268020; x=1685860020;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpdYIiJEOfZaZq6e665Bt+hRbgC5rpAPNfKzSP2GfNY=;
        b=gMnOf+P100sucv9/HNAbTVbjhiTbl82t5FnDFsunQEbjB4YdtUfhB1ZovA1ObN6ztf
         R/lC75QaVhZC6tzsHSs0F6QFRHZ9XPh752zlTrf6rN5Gt1Nwv7cOiS8qcHRukJ4TP+2o
         SN1g60804ankJn6NpZFl8XOmW48Lim9Ou54abut00uFupoKAzTLdXs9JgYIBFMXgM9JX
         nkEEHqVwACKDaoN7yzWolzp+KsbbIp3sD4BxZoIDWd94bzN3htO/U2Ah1yLbt1/9DphI
         x8ZjNCZ9N2pZWkHjXBel5NGmWWvn6k8q9DkmDZ1t52kKSjNy47HyW5DSpMUQ0l1X75ZD
         Kx3g==
X-Gm-Message-State: AC+VfDx0yQeuSnWdXT07gYFX2onRryM2UTx7cqKjkNG468nzSAx2Fgdp
	ATZjOxrN8iiy+N+HhKTvGPbZUPGb5cM5/n+PdpygN5KjnFDs8ZeC
X-Google-Smtp-Source: ACHHUZ5erzi4WZZk7svVueJvfs0ewBlg7Ah9E0YNQCNE+MuqLKc40/WSachJF7g3rQQcmdWya0RM4c+W7DUoJi5Urig=
X-Received: by 2002:a05:6808:8:b0:38d:ea6c:66a1 with SMTP id
 u8-20020a056808000800b0038dea6c66a1mr75868oic.35.1683268020426; Thu, 04 May
 2023 23:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Karthick Bhaskar <jetkarthick7@gmail.com>
Date: Fri, 5 May 2023 11:56:49 +0530
Message-ID: <CABPHfyNEHsv_Jh7SprryfApMugvDkSg6fRSG6Q-LE9=Q1hEGZw@mail.gmail.com>
Subject: eBPF verifier does not check pointer's pointing location before doing memcpy.
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Subject: eBPF verifier does not check pointer's pointing location
before doing memcpy.
Hi Team,

     static __always_inline void ebpf_memcpy(void *dst, const void
*src, int len) {
    for (int i = 0; i < 3; i++) {
        ((char *)dst)[i] = ((const char *)src)[i];
       }
}

In the above code, i am passing a char pointer without allocating any
memory to it. But the verifier didn't throw any error or warning, as a
result, during run time it didn't execute " ((char *)dst)[i] = ((const
char *)src)[i]; instruction and return. Fundamentally it is incorrect.

If we execute the same expression in the standard 'C' it must have
thrown a "Segmentation fault" error.

Thanks,
Karthick.

