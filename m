Return-Path: <bpf+bounces-11109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF97B34EC
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 16:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8252A28248A
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0478B51228;
	Fri, 29 Sep 2023 14:29:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3A4F124
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:29:22 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD2F9
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 07:29:21 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5F12BC13AE50
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1695997759; bh=9gKsGjj2Fvj10Gg8NL/+ZaghyA5FkfVhUgr0gOaMfpo=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=I/OFGeZTX9ONzPbfJj0uKm57lfLbnpGvIaqQFsCVsC6rw8979r4gq5QnKgJNGED9f
	 A7Y8Hi8nZ/bAfVytLEoFAw+z/Arhg7lI503QlQtcI5ThF3ZP63udwiM1R++ChnKVzy
	 ItXw6FWgM8sZOOaLe0Dp1TvcTm3IYJADZKqpDg+Y=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Sep 29 07:29:19 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2F4BDC151068;
	Fri, 29 Sep 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1695997759; bh=9gKsGjj2Fvj10Gg8NL/+ZaghyA5FkfVhUgr0gOaMfpo=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=I/OFGeZTX9ONzPbfJj0uKm57lfLbnpGvIaqQFsCVsC6rw8979r4gq5QnKgJNGED9f
	 A7Y8Hi8nZ/bAfVytLEoFAw+z/Arhg7lI503QlQtcI5ThF3ZP63udwiM1R++ChnKVzy
	 ItXw6FWgM8sZOOaLe0Dp1TvcTm3IYJADZKqpDg+Y=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 13872C14CE45
 for <bpf@ietfa.amsl.com>; Fri, 29 Sep 2023 07:29:18 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.105
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=gmail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8TujGA8lxeNF for <bpf@ietfa.amsl.com>;
 Fri, 29 Sep 2023 07:29:14 -0700 (PDT)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 41491C14CE38
 for <bpf@ietf.org>; Fri, 29 Sep 2023 07:29:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-692a9bc32bcso10681428b3a.2
 for <bpf@ietf.org>; Fri, 29 Sep 2023 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695997752; x=1696602552; darn=ietf.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nvalNltjLz9adeyezSdNpn/HXtzEYyQkHd66K+vSLkw=;
 b=lxEGy+NhcvKWNC+n45B7bUsCgOkFllHdpcPhNKPJOZjqbmC8BUXkbksv2f1777Lp0O
 7BKF9elphAmo4tOU9DCiISMNaDw0SOfJR6gJo6EiPR07KjM/pwOrefLp0/NqF3cdjeMj
 ejJqLjvfnK4q1YqeSonUVAuIf55DOQeswWyo70JxxbDN0L4ks75GunNR7leq2cA344zr
 DOhjiPKyRqCzl1NhFjnYQTrK6za6+ORINQ4sFQydj08YiLSI5NvltQCxEs/5ooSogJZI
 G8ueJNL14hHvXS5XXJ8HR6FOIazJyW/xbbwRpR2ZQEl66tcA0jY8OcqQUm542FtZt8jy
 0snA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695997752; x=1696602552;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nvalNltjLz9adeyezSdNpn/HXtzEYyQkHd66K+vSLkw=;
 b=Xb32gwEXHas1uu5qBrcFPU3bVf1ZC34LZlnx040k0NSHUv6k93ve/FP1eMqyfUlCMi
 pShgGFkFtLFnzKJ4lbSfa7qV8NDS0jvZMqtab8A/mSKBzILefttn6ntWVle9Mx6NgljZ
 Uz0WgHKUhu6sqmaeWLM3BjTtPMNeN6UDMZ6AifHX4FZg8IyIwfPHEP5decQsncNuvP+y
 lG59CYgMAI1w4TxJ+pBGfBOYSUWpl1/63GssOjWBYy+z7fJHlhPNh3ez2H82gzMj/5WD
 F6Ah4XAp4o5okvtygPS1UNbBz23HVfvcqye2lFY0lbMp6/mUIgY6QmskF/3QhxVbvrat
 BAlg==
X-Gm-Message-State: AOJu0YyLw9L9+IocgZ6uyA+CVPhAZrHZ7SU7AygWdVaX9yW53VPCpLXN
 UUJMJDOizb0djaSY7//9gA63MGXJkx8tEpKgS4PmtvWZ1H2bjA==
X-Google-Smtp-Source: AGHT+IEP1cqow5L1B9jqg4bj57a7SPzdNh0rz4AFtBVdAOGkLwmnUVZkoJ0JhXuqkh/Cz1r6JczroUTGAulES8FLyTE=
X-Received: by 2002:a05:6a20:9143:b0:15e:b8a1:57b9 with SMTP id
 x3-20020a056a20914300b0015eb8a157b9mr4816514pzc.24.1695997752257; Fri, 29 Sep
 2023 07:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suresh Krishnan <suresh.krishnan@gmail.com>
Date: Fri, 29 Sep 2023 07:28:59 -0700
Message-ID: <CA+MHpBoHdG4ptYsdeHaEUNqmyPYYgavWUpMbVW5zzOzUoLUJMw@mail.gmail.com>
To: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/pAY8uvXt_IxmIekVEqap4rT_qSQ>
Subject: [Bpf] Call for WG adoption: draft-thaler-bpf-isa-02
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,
  This draft has been presented at the bpf meetings and has received
significant feedback both at the meetings and on/off list. Dave has
published a new revision that addresses all the comments, and has
requested WG adoption of the draft. This call is being initiated to
determine whether there is WG consensus towards adoption of
draft-thaler-bpf-isa-02 as a bpf WG draft. This draft is expected to
address the WG deliverable

"[PS] the BPF instruction set architecture (ISA) that defines the
instructions and low-level virtual machine for BPF programs"

The draft is available at

(HTML) https://datatracker.ietf.org/doc/html/draft-thaler-bpf-isa-02
(Plaintext) https://www.ietf.org/archive/id/draft-thaler-bpf-isa-02.txt

Please state whether or not you're in favor of the adoption by
replying to this email. If you are not in favor, please also state
your objections in your response. This adoption call will conclude on
Friday October 13 2023 (AoE) .

Regards
Suresh & David

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

