Return-Path: <bpf+bounces-12214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B627C9454
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B960A2827C0
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9B10786;
	Sat, 14 Oct 2023 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Gggbtqj6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF35CBE
	for <bpf@vger.kernel.org>; Sat, 14 Oct 2023 11:27:44 +0000 (UTC)
X-Greylist: delayed 78500 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Oct 2023 04:27:41 PDT
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5AAD
	for <bpf@vger.kernel.org>; Sat, 14 Oct 2023 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1697282857;
	bh=4lOwPNqDHaEa7iIgFNGd9ZAth2MHFDRM00wxp4dfiyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gggbtqj6+0yM1Hhbqme/u5yy/fLWYKfxjuKZjX4QavU6v0Y4nXFtHO3hFhzH5HKiU
	 ZFtRItwPD2OdYdzGPdoWAtPG/rhkpj1gckIYSRj71cOHLbHM+nUPtr/sX48T95Gbrw
	 f4NZanmnWaxHWX9JdSrDpuFTiK3sS6z0w6OupIcI=
Received: from lb-dt.. ([117.32.216.61])
	by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
	id 6E39BA1C; Sat, 14 Oct 2023 19:27:35 +0800
X-QQ-mid: xmsmtpt1697282855tq9q2qfsu
Message-ID: <tencent_69D8DE86B0CF09BC89A9561C6B9771D2F608@qq.com>
X-QQ-XMAILINFO: NB6JrRGPS2/ZDR2EBPzAMHiTRN+bqEeYEva5sjQrVixiYE1BVoEceI6xEY+VA3
	 Bv3RTcS3VUwEzZ0s1fJGa1I3mMJiF3a9PKzjzQNvo1NzEzwqCD6dX/nbK7Ax4TPxRqP1RlSD1bwl
	 1XzL6YZ2uXSeRR57RopuwPVZ56NW6HakA7Yqr3/RmZKAcC/NrdEf2mNHHo6swb5Nb+bkrJLy3GKB
	 0TXhBxRuypxXI0Vfc76UHu5pqrWHIcxaHx0pNftz72JgMuEYQqdpOFi1pOWYec/wZCaivWIIGh/J
	 PxzFkGIDXTgUs2hSfddwqYyQKuBlfhm4RQ7to0Vgu/Lzfx6Qo1LvoYOJskgEuCBDTjeE+MIFIJmA
	 IRBsqRWd7xiTc/lDZNvFvDu+MwiOtZmLauBkecU37pBK+PWzjJp621cPWlMaNjW584PITWbyqswW
	 A4njAhMh4R0173wO9SNrVNqIRmsotFXJU5ZSllp/J4p6F8QHCFtYrK8pgOpV02kMbq78NdOM6U/1
	 lwXehWYvKBcucpR8/dNbvCt9CQPNx0cUVNrLPLsr5tO0jAR/pN7woCdimMqpBcsXk1MbtNEEYXyO
	 Bx140MhpozpCSro9MgAnPYL9dxzeMzQQlO06Mvi2+/17NYRZy3bKnHx7zIjO4vpg0sXMrZfA4bAv
	 8m8tCXmIftqa/czbhVOuYYewPWDmJjWu91GO4HaTzQz0FV10xkjzjx6D8IcU7vHNdJbmF5+RyPoB
	 xl/Yajx+MJYQgLlTs9nummkZgTEN5NDpBnack6RBcxcuxRiP2HzNpWIltDPMGi8CJxjAQuXvRM6v
	 57QMIiCNcKE3N+Uzr/ydDCY2290muz5E8Q4qlf7KpInaxjNQeoArgM2PIyEp/nXHtFy1Ubh8UEwU
	 ON4TDMRvcpe5N05nKnk5htJrMwKhODM6ruVNQgqdjJgnQdyptAHwwf0cJ+GXCT4z4F+eEZUFofjg
	 7QZNALoICToxG/Uu/dyspUUKvcaeObMsehvoxW6KzZxGd9McZs1w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: LiuLingze <luiyanbing@foxmail.com>
To: andrii.nakryiko@gmail.com
Cc: bpf@vger.kernel.org,
	luiyanbing@foxmail.com
Subject: Re: Re: [PATCH] Fix 'libbpf: failed to find BTF info for global/extern symbol' since uninitialized global variables
Date: Sat, 14 Oct 2023 11:26:54 +0000
X-OQ-MSGID: <20231014112654.268479-1-luiyanbing@foxmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAEf4BzZnZ=jqTxShQ7p2tp=0sT5iMEJVB+zqhf55XtwQHOODtA@mail.gmail.com>
References: <CAEf4BzZnZ=jqTxShQ7p2tp=0sT5iMEJVB+zqhf55XtwQHOODtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrii Nakryiko,

> On Fri, Oct 13, 2023 at 6:45=E2=80=AFAM LiuLingze <luiyanbing@foxmail.com> =
> wrote:
> >
> > ---
> >  examples/c/usdt.bpf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/examples/c/usdt.bpf.c b/examples/c/usdt.bpf.c
> > index 49ba506..2612ec1 100644
> > --- a/examples/c/usdt.bpf.c
> > +++ b/examples/c/usdt.bpf.c
> > @@ -5,7 +5,7 @@
> >  #include <bpf/bpf_tracing.h>
> >  #include <bpf/usdt.bpf.h>
> >
> > -pid_t my_pid;
> > +pid_t my_pid =3D 0;
> 
> This is effectively the same, my_pid will be initialized to zero
> anyways. The difference might be due to you using too old Clang
> version that might still be putting my_pid into a special COM section.
> 
> Also "failed to find BTF info for global/extern symbol" is usually due
> to too old Clang that doesn't emit BTF information for global
> variables.
> 
> So either way, can you try upgrading your Clang and see if the problem pers=
> ists?
> 
> >
> >  SEC("usdt/libc.so.6:libc:setjmp")
> >  int BPF_USDT(usdt_auto_attach, void *arg1, int arg2, void *arg3)
> > --
> > 2.37.2
> >
> >
> 

Thank you for your reply.

Yes, I was able to compile on a newer ubuntu with a higher version of clang.

However, on a development module (nVidia Orin AGX) running an older version of ubuntu, it is not possible to use apt to update clang to a new version. Downloading the source code of a higher version of clang for compilation is cumbersome and affects compatibility. So I hope that with the above changes, the project code can be easily compiled and used in earlier versions.

Thanks,
LiuLingze


