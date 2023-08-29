Return-Path: <bpf+bounces-8874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC4678BC39
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 02:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E511280F21
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 00:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A87FF;
	Tue, 29 Aug 2023 00:47:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9C366
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 00:47:50 +0000 (UTC)
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA318191
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1693270062;
	bh=LxUutieyTDutRI1JM5YEeCPiPo1Dpb9gHQrtgvK0grI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koIrWq6cwt0dYLGXnXiBA9XbHAWYLFoasGNfCdo7VacjfLWZdlINsJRtpZBUmMDwJ
	 +6vKi7rNlANRMz5uhtGlJQx2lskLAJJg8xXuRtAMLcn+a6f0mDpQ+OJVkj0Gt3qVzl
	 PONwmmLrJ8d5TFbFu5ThaAEVQl91VWooW0j77wQk=
Received: from localhost.localdomain ([39.156.73.12])
	by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
	id BE3B6E68; Tue, 29 Aug 2023 08:47:35 +0800
X-QQ-mid: xmsmtpt1693270055tucwvy5he
Message-ID: <tencent_F746AF27A3E588BF061F427F59F9979A2A08@qq.com>
X-QQ-XMAILINFO: MGSlRwRrdVfIisT3TiXB4uYFg1pb70VmVj01DWlSdnyXveEPvcdfOti4Q7+mlg
	 3vm370upAN81LRC9/x3JRq4rGtFv69eq7BpBUc1EIO+ezuZzWYVks3EJByyg33EydPy8vrJgieNS
	 2Z6R9SZeFE0PPT1HDn6njhxKOuw48AlXhRpqKEmqSywXA8XjPOoqEiGgdqOlQac+iLAKxljaBvJo
	 hF2RrRCPHzbv8DGPEAg9L6I5jCgZf6ZyGsVU20EXN2wcsHoReJuJJ0XfAVXbdkLlFupuABXVqHGu
	 jd0VcB1p4gSRIpfl18m7I5bw/HVILqal4kLI7npc5mrVwGOpw/B8P3HDRnVKEAeTtM4loIKSfGfS
	 uBgjc9H16GM95fCAsPgbYiEGWRRJX5CCNm2BxAlmAjeuir0qzLhq0BRO91mwTi2D6INeC95OiU/n
	 I0kagyzaInYM/CnD8K5UIVeQyVn/taydaNjrw1THMkVfxzDO5nmYc3OWAikwAtSeGidmXCYn/6DL
	 uKIReuw1Iv9bNPKUx9Rya9fvMk/equbsebS5l0Rvy1zVcaOzkBPf45R4sxlmAzJ3mndd9M2G8UyY
	 470Ch9UnwI7OXBFRZrpc+wXu12kUXqtNazHb2D7BoL/dlwSzWtA/+o4fz8DqJZpisd7zED0yg5yx
	 54Ywr4nKB8tVu9V3SwgFS7MaKdL7P4JmPg8S3+goUu/bJom6I+PiviJxNzMxFzAfNnTooEfwiRno
	 yaUpEtGelmDznC95nZYnsHD1TQxoDgWPLI1OkU8AO7bcqSUnIMa7C6GB4zhimzed/uiL4wInWQvC
	 JqsML0mv6f6htaA3tCIEOlI+mu/ucVinF85nNJobmVUVe1e6p+q++qkzrtlW3oZIHdCNylaIC25g
	 ct0J8TTWg0ujX7S83T4uc/Yg0zFh+0qFWVe/ukPQBfVn8blD5/VHPcJm/OnTpTO/UZICgMDLr0oS
	 K3zDZM5OqIvEwHsJEbRJRndGKzShRoSxMqY3/3Kf6VHbv54j84pYcOUjkl9ev3
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Rong Tao <rtoax@foxmail.com>
To: olsajiri@gmail.com
Cc: alexandre.torgue@foss.st.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chantr4@gmail.com,
	daniel@iogearbox.net,
	deso@posteo.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	iii@linux.ibm.com,
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
	xukuohai@huawei.com,
	yonghong.song@linux.dev,
	zwisler@google.com
Subject: Re: [PATCH bpf-next v8] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date: Tue, 29 Aug 2023 08:47:35 +0800
X-OQ-MSGID: <20230829004735.99516-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZOynCqBv/JJyZ2Kj@krava>
References: <ZOynCqBv/JJyZ2Kj@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Hi, jirka. Thanks for your reply.
> > 
> > > > @@ -164,13 +165,14 @@ int main(int argc, char **argv)
> > > >  	}
> > > >  
> > > >  	/* initialize kernel symbol translation */
> > > > -	if (load_kallsyms()) {
> > > > +	ksyms = load_kallsyms();
> > > 
> > > if we keep the load_kallsyms/ksym_search/ksym_get_addr functions as described
> > > in [1] the samples/bpf would stay untouched apart from the Makefile change
> > 
> > Maybe we should make this modification, wouldn't it be better? After all,
> > not modifying the source code of samples/bpf is not really a reason not to
> > make modifications to load_kallsyms(), what do you think?
> 
> I think we want separate selftest and samples changes and I don't see
> other way to do that

Thanks, jirka, I didn't notice this in the previous discussion, sorry.
Let me try to solve this problem.

Rong Tao


