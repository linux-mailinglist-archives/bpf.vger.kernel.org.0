Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD24C8CB7
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 14:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiCANef (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 08:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiCANee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 08:34:34 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29557E08F
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 05:33:52 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nP2dS-0006HL-6I; Tue, 01 Mar 2022 14:33:50 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nP2dR-000FJc-VD; Tue, 01 Mar 2022 14:33:49 +0100
Subject: Re: [PATCH v4 bpf-next] Small BPF verifier log improvements
To:     Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org
Cc:     kernel-team@fb.com
References: <20220224003729.2949667-1-mykolal@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <feebf924-426a-7128-993d-10a642088ccd@iogearbox.net>
Date:   Tue, 1 Mar 2022 14:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220224003729.2949667-1-mykolal@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26468/Tue Mar  1 10:31:38 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mykola,

On 2/24/22 1:37 AM, Mykola Lysenko wrote:
> In particular:
> 1) remove output of inv for scalars in print_verifier_state
> 2) replace inv with scalar in verifier error messages
> 3) remove _value suffixes for umin/umax/s32_min/etc (except map_value)
> 4) remove output of id=0
> 5) remove output of ref_obj_id=0
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>

Thanks for helping to improve the verifier output. Small comment below:

[...]
> diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
> index 0ee29e11eaee..210dc6b4a169 100644
> --- a/tools/testing/selftests/bpf/prog_tests/align.c
> +++ b/tools/testing/selftests/bpf/prog_tests/align.c
> @@ -39,13 +39,13 @@ static struct bpf_align_test tests[] = {
>   		},
>   		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>   		.matches = {
> -			{0, "R1=ctx(id=0,off=0,imm=0)"},
> +			{0, "R1=ctx(off=0,imm=0)"},
>   			{0, "R10=fp0"},
> -			{0, "R3_w=inv2"},
> -			{1, "R3_w=inv4"},
> -			{2, "R3_w=inv8"},
> -			{3, "R3_w=inv16"},
> -			{4, "R3_w=inv32"},
> +			{0, "R3_w=2"},
> +			{1, "R3_w=4"},
> +			{2, "R3_w=8"},
> +			{3, "R3_w=16"},
> +			{4, "R3_w=32"},

Ack, definitely better compared to the state today. :)

[...]
> @@ -161,19 +161,19 @@ static struct bpf_align_test tests[] = {
>   		},
>   		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>   		.matches = {
> -			{6, "R0_w=pkt(id=0,off=8,r=8,imm=0)"},
> -			{6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{7, "R3_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> -			{8, "R3_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{9, "R3_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> -			{10, "R3_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> -			{12, "R3_w=pkt_end(id=0,off=0,imm=0)"},
> -			{17, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{18, "R4_w=inv(id=0,umax_value=8160,var_off=(0x0; 0x1fe0))"},
> -			{19, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> -			{20, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> -			{21, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{22, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> +			{6, "R0_w=pkt(off=8,r=8,imm=0)"},
> +			{6, "R3_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{7, "R3_w=(umax=510,var_off=(0x0; 0x1fe))"},
> +			{8, "R3_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> +			{9, "R3_w=(umax=2040,var_off=(0x0; 0x7f8))"},
> +			{10, "R3_w=(umax=4080,var_off=(0x0; 0xff0))"},
> +			{12, "R3_w=pkt_end(off=0,imm=0)"},
> +			{17, "R4_w=(umax=255,var_off=(0x0; 0xff))"},
> +			{18, "R4_w=(umax=8160,var_off=(0x0; 0x1fe0))"},
> +			{19, "R4_w=(umax=4080,var_off=(0x0; 0xff0))"},
> +			{20, "R4_w=(umax=2040,var_off=(0x0; 0x7f8))"},
> +			{21, "R4_w=(umax=1020,var_off=(0x0; 0x3fc))"},
> +			{22, "R4_w=(umax=510,var_off=(0x0; 0x1fe))"},
>   		},
>   	},
>   	{

However, not printing any type info here is imho more confusing. For debugging /
troubleshooting knowing that the register type is inv or scalar would be helpful.
Fwiw, scalar is probably a better fit, although longer..

Thanks,
Daniel
