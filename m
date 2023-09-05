Return-Path: <bpf+bounces-9252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EC792370
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F231C209AD
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652BCD531;
	Tue,  5 Sep 2023 14:22:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68FD513
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 14:22:18 +0000 (UTC)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0330D189
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1693923725;
	bh=HENdTPz9DKLgwbLK0xXsSzaRwMyikMlHnYMJdwmq++0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7EaYOp5egAJsKwnA8munvzl9JiKOzBwhRK8/WJHf+uurhgJdAZG47SHzkELlCTwB
	 JpP1Bod9ZPJf86/SDiJmNYzwwJItNk42oS6MIi5iDp75H9VGP5PjFfAUEK3rlxiIL5
	 9TvPGp4gqOwNdpfCQmzOm/DznxiW/b1PqcSNW/jc=
Received: from rtoax.lan ([120.245.114.157])
	by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
	id 580046EB; Tue, 05 Sep 2023 22:22:00 +0800
X-QQ-mid: xmsmtpt1693923720t1sy3uo3k
Message-ID: <tencent_2D10CB0CD885A8B2A42EAB546E5EEF467B09@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS5ZQPGHX+/hR4HEKI2ljXem8GivFomlSl2eDzLj1NiT397Jr5pD
	 8nI9TJ9PMGRcMnU/o/lcNJwmB8eE3spPvl53RKPPydsXy2XxmhL5Xbo6b3tyLa3tm6GB0twTnT1k
	 XnCeFIYs5MvEvK9rP3UvLqdIy4EBciqWWabXZNCrwQ6M68HyrKvBPzaNSX5ChOyk55iPAKs/MZgH
	 NdLJbxm7G9auXiRPutnh5FyX2qJYWYWwxOqZUZfMIMMS1M0W6sJV30RAevtPiC+EYnI5RQ8N7pDq
	 dlNsmW4rJNQwYL8cWyPLLXaslEbu51mntl4vGEXxiSidInFK8RUo1+7zEM/k3qSq2owg5iOTcleO
	 kNDEqHXtSn6aUB3rpWUTslfqXNCPnZv3zkNaeY5UDXdK7jf3bW3un6ApZnVs+j6BqCX+T4SbiLWF
	 wKfoTpO5FXTHQUqByPMnE6Lcq9ELoZyK1PK+LP6ZOPRdnI4CUtF7CufpFUGpxW+0JtsdmYWt1UOa
	 Ptdj9W33+EJ9qtwDOy3D0ifyoQBuzhTgm56Fwe7glclWed0OyGYfYaIGWdVe8KBLhgYMWRWBB5I7
	 eZQ3bWBqlIpkdmMA8Nz+OwHoNV4+J/vej98+WtOV8C8RYfzrwOaLMf5xEqmf83gpWV4vJ9LCJs4W
	 OuMcEzmX/3JOzG/VHst7kryEPYYG8d6IKSMPDwzJnhyAL68Z4HBYRTKiL47KSA7GKR52DAaQuc7m
	 DbTMchSTmwiU7lPjevb7ZUMD4iTYgbneF99Xz/ujZWLreCzVNqvURl6lRSB94n3/cFaTcTEIBboc
	 PvOOIhw/pDwjQkw+3M3JmAvxIiIIQDvkGLJreVYhIcqJBHtHqIe/8ebzngGeivwt0B1kPhhygoUH
	 lnav8x5/yOs8CfwhhkTRbXm6RdrFBE/ES5gUmRhGlq7aBmlOHExNAGcoUOf1TFpLaCLuKxSowxu8
	 3kYG7KvR6ysnbGGiGoohMCNtb+DV16G0GJuaUybFE0xUPATzDfsiDAk83DnYqmp/yhq3e4jsyoV/
	 mByZ4qvFfYoRjGczcwKdFEysvUroc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com
Cc: alexandre.torgue@foss.st.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	laoar.shao@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	martin.lau@linux.dev,
	mcoquelin.stm32@gmail.com,
	mykolal@fb.com,
	rongtao@cestc.cn,
	rtoax@foxmail.com,
	sdf@google.com,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v10 1/2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Tue,  5 Sep 2023 22:21:59 +0800
X-OQ-MSGID: <20230905142159.114458-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZPY1Lu8341L+d5Rw@krava>
References: <ZPY1Lu8341L+d5Rw@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, jirka.

I just fix all your advise[0], and submit new patchset v11.
please review.

Rong Tao

[0] https://lore.kernel.org/lkml/ZPY1Lu8341L+d5Rw@krava/


