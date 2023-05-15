Return-Path: <bpf+bounces-573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D423C703EB9
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 22:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EE1C20C2B
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC20182B3;
	Mon, 15 May 2023 20:43:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A46FC0A
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:43:00 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01252AD11
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=1MPQTClBUZ3YUpkAfYQMeyKLf1vjqrmx/6426rzKQ98=; b=dL6OoBvuddjb5JioTkRca/5B2/
	t/jWL3N7OQfK3A3yG9hMv0GTJup5ecPZGjko3XtHwLvJIPc6vgp37kZFEFZ3U9yMLXU0qTmBsGwat
	iwOGfSV/Yb/K9+SJeGkdmtNdM2eKblOQmIwAXYiIGgdmoiro/zMzGD0ibbLUioQFbt7ojQ4076N6J
	wVqhyC9HyoA6AAbNtA4neXKFG9bo3uuyGbL1ZutHjbwNbNKTJPqgmo0rCMb0AWUQeha6vXQtund7J
	YCrj0tWJsmMowTDJHyjsMZP0rluey5wVr6EzAqC59tgrRjSu9cLTtrO23637htJanYbYnxryQXmHL
	AhjuY9xg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1pyf1v-0009KJ-Ra; Mon, 15 May 2023 22:42:51 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1pyf1v-000PDm-5e; Mon, 15 May 2023 22:42:51 +0200
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Remove bpf trampoline selector
To: Song Liu <song@kernel.org>, Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 Jiri Olsa <olsajiri@gmail.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
 <20230515130849.57502-3-laoar.shao@gmail.com>
 <CAPhsuW545Lf=q91+L_o-ZRwpWs2xUbmoWU9CK4zNae=Dy=kSWg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c44eb4b2-1d93-890c-d668-6f86f4d2d9b9@iogearbox.net>
Date: Mon, 15 May 2023 22:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW545Lf=q91+L_o-ZRwpWs2xUbmoWU9CK4zNae=Dy=kSWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26907/Mon May 15 09:25:12 2023)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/15/23 5:53 PM, Song Liu wrote:
> On Mon, May 15, 2023 at 6:09 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector
>> is only used to indicate how many times the bpf trampoline image are
>> updated and been displayed in the trampoline ksym name. After the
>> trampoline is freed, the selector will start from 0 again. So the
>> selector is a useless value to the user. We can remove it.
>> If the user want to check whether the bpf trampoline image has been updated
>> or not, the user can compare the address. Each time the trampoline image
>> is updated, the address will change consequently.
>>
>> Jiri pointed out antoher issue that perf is still using the old name
>> "bpf_trampoline_%lu", so this change can fix the issue in perf.
>>
>> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Jiri Olsa <olsajiri@gmail.com>
> 
> Acked-by: Song Liu <song@kernel.org>

Lgtm, I took this individual one for now.

