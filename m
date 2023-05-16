Return-Path: <bpf+bounces-594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E570434A
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 04:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2338A28143E
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02C523BD;
	Tue, 16 May 2023 02:15:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAD23A2
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 02:15:27 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D274231
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:15:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so23792909a12.3
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684203322; x=1686795322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmW4rabBYGrMSrHrIlKazVNo/yNKOJy3JS8TSLBbtz4=;
        b=q/7kGUoDV6jPUAnaUAD8AFodgiIpFhPxxb8bNLKAtuWEPuqG0pRtqDyKin1DRYTDPw
         zzjI7qYpa+MD/EompqjcvKijttlEsPdg+r1d1LqSyeoQCw5UsPtQkw0f3/cbeFfH1OJJ
         PmKOxozSac3SSiMCDZgQpQu/4b3XaQ4gY4MZucHZIVsckCENfsN+sZbAPZWXzcStiYZ3
         Xxt2JBhCoTaZh6wgHFE5cfInLyvLDWXT6Un1g5NCx5Mv7+zCpZuYTnTPvEdBnwtzHRo1
         Wr1RaHvdVMMMjKqZiabJ9iLlIPldzKx1ZD1ilO11cKaOogpPrmYEHs0PJAz3YO4+rmg/
         2sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684203322; x=1686795322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmW4rabBYGrMSrHrIlKazVNo/yNKOJy3JS8TSLBbtz4=;
        b=Or7KS1If+mmhuQUYooPoLbEkcso8p8tZwd9Ep0xlxNxVBn7OrOA/UxTPSaNQxSx5wc
         xZS8mr6BFYUbJHwxrGTlBScF3jvSHfbjusQgaJkitmbvh9JeGU3rPXD2wAS+jvVQD88s
         KlO7EJi6lQ1YJvy6HT2b0aXzm+WX+SrCcZwCnUq9Py+0XD5AQmodBWQ5U/MTpt9izuj+
         QO4rlDNB80E9SNPk4CxgCtz7ENl4uTb3q+3vzC9mdN8beNjfEfHzXShFQagdpZCHYcJ2
         YZOfek67vxSset9nFkUvwwwUMLEONMzyA43jTxM628k1+1EP+Cq9AAssrAlpx5pk2rFo
         s7/g==
X-Gm-Message-State: AC+VfDxFwZzGqjW5UdMPIV77COo6S7LGzyNlrSaK1HmSViSgu9b0FY5E
	rFNbBPBteuralDjFfz/69bK378f35EaghAjv93A=
X-Google-Smtp-Source: ACHHUZ6WpGxo89XbVz24EcEbkD79WtRYrkDbyrCA7iw4I6kcAocQKjbzMSdKhMYlo/1DXkSMhnaAcD6Z10qA7QC6dJU=
X-Received: by 2002:aa7:d88f:0:b0:50b:c1e3:6f02 with SMTP id
 u15-20020aa7d88f000000b0050bc1e36f02mr28022210edq.21.1684203321686; Mon, 15
 May 2023 19:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230515031314.7836-1-zegao@tencent.com> <20230515-dominion-botch-e0b9291bcea3@spud>
In-Reply-To: <20230515-dominion-botch-e0b9291bcea3@spud>
From: Ze Gao <zegao2021@gmail.com>
Date: Tue, 16 May 2023 10:15:10 +0800
Message-ID: <CAD8CoPBi0OwWbFzfACvLw0EiC14E_QtsssV4UP7KJctsOmAa-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Make fpobe + rethook immune to recursion
To: Conor Dooley <conor@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ze Gao <zegao@tencent.com>, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Conor,
Sorry for making such mistakes,  it's my git--send-email sending
script that does not work well.
I'll send v2 and double-check the cc-list ASAP.

Regards,
Ze

On Tue, May 16, 2023 at 1:44=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, May 15, 2023 at 11:13:09AM +0800, Ze Gao wrote:
> > Current fprobe and rethook has some pitfalls and may introduce kernel s=
tack recusion, especially in
> > massive tracing scenario.
> >
> > For example, if (DEBUG_PREEMPT | TRACE_PREEMPT_TOGGLE) , preempt_count_=
{add, sub} can be traced via
> > ftrace, if we happens to use fprobe + rethook based on ftrace to hook o=
n those functions,
> > recursion is introduced in functions like rethook_trampoline_handler an=
d leads to kernel crash
> > because of stack overflow.
>
> This patch series is a bit confusing. The RISC-V list got 2 cover letters
> and 2 patch 4s, but not any of the rest of the series. Please at least
> send the whole series to the list so our patchwork automation can be run
> against it. And mark it as v2 while you are at it.
>
> Thanks,
> Conor.

