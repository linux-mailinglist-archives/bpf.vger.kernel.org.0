Return-Path: <bpf+bounces-2127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822BE7284EC
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458EF28170C
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C016174FE;
	Thu,  8 Jun 2023 16:27:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2735716432
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:27:31 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC919B
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 09:27:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2568fc3d8a9so452897a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686241648; x=1688833648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3eYHbt3Lra1h4IhwyjExc7YWHHEJ0+HYZYvn3NDBAE=;
        b=ZEJf3h16GMcrTLSlduQ0E82dKUprjaM9roz0jT7T7pEe7G3uVc1dE05sNT+LkTDrEC
         /qM3OyDEQ+QOYC47l4Xdub3HV/0619WfaOevCghUyImF9dg+U824Zbsj/noxGajNsdyq
         JQxCGez9axSQNYR16Ilj6r4Jn5HGh83iRTX1H6tIPI59k29BTqDao4EkJ18lavFNzg9F
         pmKx17nnmxG2R67NCCmpuP6IJLy4D2Ij+7AE+qxn6f3VXR1NjOZF0LCBPqXM5+9YvSDf
         YHXrw5kzs7XlSsrW1YXQGvFdr79UIZKyEv86TPjupcMONY0prUBil6Qdth2yzYBsPKRK
         jtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686241648; x=1688833648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3eYHbt3Lra1h4IhwyjExc7YWHHEJ0+HYZYvn3NDBAE=;
        b=iKAhTtDqyIqOEqYYLMrHlp0ly/zSOjlDPgEXLAblIIlEKuGYILnNwlpKJMBmEVYLuV
         O6ZAq60NqINf9hKeBM0fI4e6/N8qgsxbXvh1hzguDljsfjbL+uPPNYmvWXjXrpVepstn
         Dho4Wmhtfe4DoSxc52ONk/kWPnTDezclw8R02mewbZlD9Me0+XTnPZp0F+J63RckYiWz
         CNxFlUvyJRKyVV/858HDli/SBNMXePDczSQWg95og9RgZtBWtd99WTcJ/1bFZ5YJRtfz
         QomY3e4+6yQ72W2kbOHsCJ7F/JyPe4vsRthuTZNVe+u8Hx0C/sLwyuz2rBGKpEea5rSB
         qssw==
X-Gm-Message-State: AC+VfDzBaPjRMUYmIMzhgkpCkmw+QRKFUGIdplzVe9vye+ft2CV+4ocs
	7hARM7g2dFeAbGWFRoSA2oYKw8eDfXYGIp6QD89Acw==
X-Google-Smtp-Source: ACHHUZ5qItCfNUSImOGTZHLML//41tvvyp8NY5dYgoTsxWTmx4DIWjL9Wm8uizV3JycuCeZu1n8kXr3UNcJAUdYi8f4=
X-Received: by 2002:a17:90b:1b4b:b0:256:3fc7:59fa with SMTP id
 nv11-20020a17090b1b4b00b002563fc759famr3963530pjb.9.1686241647804; Thu, 08
 Jun 2023 09:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZH4a1l1pfG8ewo3v@google.com> <20230608125820.726340-1-zhangmingyi5@huawei.com>
In-Reply-To: <20230608125820.726340-1-zhangmingyi5@huawei.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 8 Jun 2023 09:27:16 -0700
Message-ID: <CAKH8qBunUNSHDHQysavzS2PwXuro8aHanS8_3=8GYSEvib=5SQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf:fix use empty function pointers in ringbuf_poll
To: zhangmingyi <zhangmingyi5@huawei.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hsinweih@uci.edu, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kongweibin2@huawei.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	liuxin350@huawei.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, wuchangye@huawei.com, xiesongyang@huawei.com, 
	yanan@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 6:00=E2=80=AFAM zhangmingyi <zhangmingyi5@huawei.com=
> wrote:
>
> On 06/06,Stanislav Fomichev wrote:
>
> > On 06/05, Xin Liu wrote:
> > > From: zhangmingyi <zhangmingyi5@huawei.com>
> >
> > > The sample_cb of the ring_buffer__new interface can transfer NULL. Ho=
wever,
> > > the system does not check whether sample_cb is NULL during
> > > ring_buffer__poll, null pointer is used.
>
> > What is the point of calling ring_buffer__new with sample_cb =3D=3D NUL=
L?
>
> Yes, as you said, passing sample_cb in ring_buffer__new to NULL doesn't
> make sense, and few people use it that way, but that doesn't prevent this
> from being a allowed and supported scenario. And when ring_buffer__poll i=
s
> called, it leads to a segmentation fault (core dump), which I think needs
> to be fixed to ensure the security quality of libbpf.

I dunno. I'd argue that passing a NULL to ring_buffer__new is an API
misuse. Maybe ring_buffer__new should return -EINVAL instead when
passed NULL sample_cb? Although, we don't usually have those checks
for the majority of the arguments in libbpf...

