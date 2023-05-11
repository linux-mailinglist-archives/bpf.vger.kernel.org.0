Return-Path: <bpf+bounces-332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B906FF3FA
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA5A1C20F3B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A911D2A1;
	Thu, 11 May 2023 14:22:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFE19E70
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:22:28 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E6106E6;
	Thu, 11 May 2023 07:22:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QHDcK4bL0z4f3l8W;
	Thu, 11 May 2023 22:22:09 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCneK8R+lxkCyLsJA--.46604S2;
	Thu, 11 May 2023 22:22:10 +0800 (CST)
Message-ID: <7d5cc151-e6c3-73a9-59c0-c4e5821cec1c@huaweicloud.com>
Date: Thu, 11 May 2023 22:22:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2] arm64,bpf: Support struct arguments in the
 BPF trampoline
Content-Language: en-US
To: Florent Revest <revest@chromium.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 kpsingh@kernel.org, mark.rutland@arm.com, zlim.lnx@gmail.com, yhs@meta.com,
 Yonghong Song <yhs@fb.com>
References: <20230511140507.514888-1-revest@chromium.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20230511140507.514888-1-revest@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCneK8R+lxkCyLsJA--.46604S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr13uFWxWr17CF1rWr4kJFb_yoW3WFbE9F
	ZrtF97G398t3W3tr129r43Zr93CFW7GF13KF4ftryIv34kZrWDCa4vk3sxtw48tFW2qFnx
	A3Z8tryIqrW3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/11/2023 10:05 PM, Florent Revest wrote:
> This extends the BPF trampoline JIT to support attachment to functions
> that take small structures (up to 128bit) as argument. This is trivially
> achieved by saving/restoring a number of "argument registers" rather
> than a number of arguments.
> 
> The AAPCS64 section 6.8.2 describes the parameter passing ABI.
> "Composite types" (like C structs) below 16 bytes (as enforced by the
> BPF verifier) are provided as part of the 8 argument registers as
> explained in the section C.12.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> 
> Diff since v1: The stack layout comment now says "arg reg" instead of "arg".
>

LGTM. Thanks for updating the description.


