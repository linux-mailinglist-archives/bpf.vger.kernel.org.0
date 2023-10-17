Return-Path: <bpf+bounces-12403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833E7CC2BF
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19BEB21260
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0042BE9;
	Tue, 17 Oct 2023 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mazFBsAL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnXrCCou"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADB41E36;
	Tue, 17 Oct 2023 12:15:49 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3D30E5;
	Tue, 17 Oct 2023 05:15:47 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H2tnKV004195;
	Tue, 17 Oct 2023 12:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ETc9LN0bxFhW3jLGgJz92S+roSiHFXra/QeM9CjUaQM=;
 b=mazFBsAL/RwA+QYjdqip6mTvyHpSrG3tT6ceHP6tmK3EmWk95QP58/OYi+vjH6q3yB8k
 ZWIp6P9A5TGjXdyu0Cj59ZEjrFdUtcMpgcu5uEFlmgqcQX9rsApGwJAub269BBj4plA+
 w3XsgPl2r7idKNQL2la4virqNNy3gtUf5J2RC12/XJJrhx4TEEEE2YnHBWL63Kf47U3S
 RH9U0oQ7Th0aMQkt9ooBFkKv78M6qd1GS491UNGDSmAM1pn4DbbCvnUN6VuTaI6UK4K5
 4IeoyP/jVO9eXbwbS51x925hAG10xJUF3007EHY3QUlOUmz6ZuWBENBkBBuBHm9ix843 CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cd0w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 12:15:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HC0NFa027313;
	Tue, 17 Oct 2023 12:15:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg53rqut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 12:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRboOaM3tlch7uiLLDHCVjPTjcTB/pCiEsNF53o4MsPBZBFKqgy4GIBDkoegRRtQfkNBmH01OrqlFngLZHvgQPLJ0xdTmTmj24ax9UcQHsGHYz/2t7N0nTQ8+2q3RBuJYtID0O35nicNl7T2Q5JmKMMPrgoZaG5/atqSLNYNvltThxmf39sAL3d8hpaquw4r43ONmrJv+JBWsqAjSOIPgNLT3qflNme+IDu2yxdigyhMe2j2EvZj1XlUTaoCXnos/Xb4JKnPbJOMsvR6YVSCE/bdxjow9thGe+8LijrZg7Y/xNfLNQu2gkjA3ZHFW+mapmpR5mrQMn404u0moa6oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETc9LN0bxFhW3jLGgJz92S+roSiHFXra/QeM9CjUaQM=;
 b=O3WMVb3bhC8h2+hBMGorvVUN2Fxy7Q6ZACUkYhNubP+LRbTRC6O5icWYCj7EEw6erzTlmI1ylUHjEVsmyg08yqft0ONluMf89P87mb3oIzFs8i0Nmml59tYsthe601ibC0vpXfUnTU+xJxe5lyPQ3yRkuPhvU8nkS3kCCQSl+csv4gccnmuqHut4geGFw3aP/DHYNBYhsSfAtS8yI7iehLYq2v1KBVcnUjN8Vnhq54K79Y958VriP5Sh3Bs9or4Dob/RF3RY9VjvbzIBOE0HhfW8XQlRPOtEg8xNtBCTkWZ6ejiZvntO1fcTWIhekupVKh8Y4E7TWWbhbveroRS5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETc9LN0bxFhW3jLGgJz92S+roSiHFXra/QeM9CjUaQM=;
 b=mnXrCCoulvTInlp/Wd3UKSGCGaXsqC+AbWcJ/a6NsC+FmYphW4jAYIxGJ9IWncT0wG6SUNc4IL4pIQMFCNrmLKbTGE4O2Qko4VIWsAIbL0XXOYyWHq66ztZC30tP4Fw6S2m9x1xxdUaMzkbE6HjEYzZPT3U8rIJrk+86fy847c0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB6984.namprd10.prod.outlook.com (2603:10b6:510:288::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 12:15:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 12:15:03 +0000
Message-ID: <30596a99-ac3f-5394-b0b7-e23037f2ae8e@oracle.com>
Date: Tue, 17 Oct 2023 13:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of
 scripts/pahole-flags.sh
Content-Language: en-GB
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, Gary Guo <gary@garyguo.net>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org
References: <20231017103742.130927-1-masahiroy@kernel.org>
 <20231017103742.130927-2-masahiroy@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231017103742.130927-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: fb904966-81ef-41fe-46d9-08dbcf0ab17b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uqPbHulviKJrk2hivGYYJ7vqr8xbLn7d5Z1bWafAzmNCc5rSNBCjOenjfhq1R6fd4IQOH0syCkeAgrzyW3NpF7HezH+6YGvCxK1ah7m3lxNJAix/Vukb6+paWFLLfoDbRew1RUvmbkQpHLvLucDMU4ClPo8c1rotCBqQLB64GUOp4NzgyVySs9tuPx1va/wPo3z/Bj2ZSdx7jFi7awKbwIx6STejlmSmBWdLRaRNAyIWRpMVxouMVY2jwGVbXFWlX85Aa6q21ogg3WjVhFaRPRGk156VIgdnfk7v7+tQQ7okZWdgQO8Pb/j6AA3nJfeeRUTMIrt7e5GcRCPqDqLx1Gd3cVY8+NJ4z8hW+DKJgZ5uEund/lDuo+dQCXxrHtFr2USEyccN01zlzuAB0/8xOrNnYbdHJGtA5RRuNazj0sWePF/OreLOn8FX3STukRmu8Q+gP/ZwuGGeZ+08oJNGyWyQFDy3EbqRlklfgPp7E82hkPfRYOmFku5V23muOQ5YkCzyw1KP9b47FEq0Ey/F1RJiAWCPolqQO/3u92vMFMuqXfbhWf5KNRtDAgkaSiAbNa4r56VQb/dhkXiqKdZ1AGST+c423KgiSjGJ55xOCbmOj55divby3W615ODhoISOTMhPScIPGc3HZodb+2ICKA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66476007)(478600001)(66556008)(66946007)(6486002)(54906003)(966005)(6666004)(6506007)(66574015)(6512007)(41300700001)(316002)(2616005)(5660300002)(8676002)(7416002)(8936002)(2906002)(44832011)(16799955002)(4326008)(36756003)(86362001)(31696002)(83380400001)(38100700002)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFNlK1RTZnBJVUVqM21sZ3JTMmJFYzQ1R2lhRm9CZHVKV0RXWXJ3ZFBTekhX?=
 =?utf-8?B?S21Pb25icXAwckFqZHc4WHBBQVQ4Yk9zNFVIVzhGTys5d3NHVGltTzQxTVlt?=
 =?utf-8?B?bnJyYVBDT1NOMlJ6ZXE2aTdHNUxJeGIyVmhCYk1USEFRbGltdHNLNlZtblE3?=
 =?utf-8?B?bWRFTytxTXQ1ZHZ3WjdodzI0RVMxck0xUFE2Y211WHJJRWxYemJxeVdHUjdK?=
 =?utf-8?B?R0p4d0ptY3d0Y0Vxdml2R05zODBiRmtCdy80Ymx0TjluQmpXa29VSm83b0hM?=
 =?utf-8?B?OFdoUEc0OFM3U0g0MHJqN2hNTXpmOUdnZFV1WmNzcVh4bzVFdXhwdkt4dmN3?=
 =?utf-8?B?YVU3M2Jld1Z6WW84QlF2STdWMHlvbUdScmFIU0l6R1MxVXZpdC9CWjJBNkFC?=
 =?utf-8?B?SzBOTTIrZ2hkbS9nS3Z4M1VxMXF0SDE5d09YdnI0NjBRNHJNVElMUnJ3Vk9r?=
 =?utf-8?B?eXRZNktpTXZqd0FxdStBOFU5alg4M1YyZEk1eDhuaTNhdzRLKzRLZSt2d2ZJ?=
 =?utf-8?B?YzY2YUJHR0orcEIvR0xWcnlCa3JYS2ppZnhSSG53TnVPcm80MXBtWXQxc0s0?=
 =?utf-8?B?a3NTbGd5Tkc5dDRXd2s4MkZvN1ZCQWhFNTFmbzRkTkJUQ0VSdkZWdkhkWCtv?=
 =?utf-8?B?VnVCQ1hhZ09aM0JUY1plWHFONXh1Nmt1WVMwdTJuODJHbllmU3F4UEIraG02?=
 =?utf-8?B?bTBvaE9jMXpkN0k3MERWVkY0NUdDTkNISERFL1VhaGUrY0Y3bHBocno5Z3c0?=
 =?utf-8?B?WE1IdDZRSTduRUlpWjFKbUt2WEhhYUVycVpnTXZMYnJmQjhXZHVDc3lBNzFT?=
 =?utf-8?B?Tm8rbHNrS2tBc1RYdFYrMEliRTRhSkQwcXFwRlZ3dm8zZWhuQ21XaitoRzBp?=
 =?utf-8?B?ZEZtOHk4VDFoZFlDb3VRZDNMWUx3S2l6bFJYMURQdGdhSCtERzc5RmdvN0VD?=
 =?utf-8?B?SVo4b25XK2xxTEdrQm1WcEZ0Uk8xTENyTHNxK3dVcWFKZTFYT2tDUXhHaDhz?=
 =?utf-8?B?TnVHMy85SVI5RWxlM01HNGhaMytnMGY5ZHdEMEY3TWZPTmtNSXBjWWpyT1N4?=
 =?utf-8?B?dmREVEdCQThteHQ3eVZra3ovcGsyemFyMnNVcncyVW8wT3pwaHhEN1Z6Qkh1?=
 =?utf-8?B?ZElHZ3NmSWFUenNvSUphOWE1REVzR1JwMlluQmM0MmN0NldzS255VExBY2Ew?=
 =?utf-8?B?RElRRG81T1RCV25kT21jaWpYUDdCbkVmN3dtOXpjVndMR2lCNXorMndZRFJR?=
 =?utf-8?B?VVB6SGFnUEF0QlZlTEkzcnZWeE1WQW9VUVg4ZGViU0FBQnUvZ0gwM0NnVG00?=
 =?utf-8?B?MlBkOW11bHlJYU9jMUtnemFQL1E0clkzM0hyZ1FSaGdZWHI3VHdaN1A0UWRP?=
 =?utf-8?B?V2JlN1dnbHAwMDJSQmYxUGI4UUFvK2IrSHFMWVlEWkI5SXAzWGFaYjZQY0sr?=
 =?utf-8?B?MFJsM1E0TjcrZG5zVnVmb0k1THFBUDFPMnJJVlpJZFJJOEFPc1RNQkYrOStr?=
 =?utf-8?B?Ni9QVytyb3EzVGVyVGRtV3d4VEQzTXRvaFp3MmZCRTMvc3p4ZU5WV1E2Wm9l?=
 =?utf-8?B?TG15VXBJSnpJY283ZkxWbnE4YVRNY3ZQK1VYcldhcnY5SzRaTXM0eDNFVE9R?=
 =?utf-8?B?cWovQ2Q4eFJhc0hoaWYzRWVocFUzcU04MEVVc0Q3T3JNcWl1a3lxRE1Hdmhs?=
 =?utf-8?B?UHhjdTFnUVZXSTRzQVhEelFnWFZrY2ZtMnlXdmVUcDAvWDNrdzJtNU5MMHlI?=
 =?utf-8?B?OURrY3kxeDIwSFZvdHlOeisySmFlc05pcXl3amdvYmI1R1BtNmNjb0EwdWhX?=
 =?utf-8?B?TFlLa1NMQXIrVjZqTHBuN2RpcjNqY0hZY05mK3hrVHpJMDYwemdnTzhUYTY3?=
 =?utf-8?B?a1d5S3MzNnNmbm5xeXZKUUZxdGdHdDVsMmo0YVViTjYrU0lYczlER0tOcnpu?=
 =?utf-8?B?ZENkQXZyci9FM3dkZ1UzMU56YVhJc1lPY083NWkvRnJFejlkdFgzOUR6UGkw?=
 =?utf-8?B?WGQrNVlSQUM2aXlzSzVBSGlHMmFQT2VnV3pZL1pSUFpRWU93bEQraUxLeVBK?=
 =?utf-8?B?dzdyeGZrN00xNTg2VU9vVEFyV0hLUGwzSjQ2TnRuRkFMZTJVZzV0c0VmdDR4?=
 =?utf-8?B?bGtnbEdKc25PNjI4T0NRS2F4aFdtWVRBVjFsbHJUcTRiTkRYZm12cnNDcTRp?=
 =?utf-8?Q?/3FW73oS75kNwMWqFY4Fjes=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?bG5LbjFFb0I4ak1pUFBKaEYzYi9wekIxbEZ0ZDdkdEN4WXFTN3YvTlhZZWF0?=
 =?utf-8?B?OHhQSFFhTGppVHd3ZmtJOEtreU1lZDUwZ2dzNWszVDcxK0M4ZXlSQVdNOWY0?=
 =?utf-8?B?VFNoZGM0citUaTBDYUEvZS9NcHhHZzhLQ2hvVVdWRklQZkNwN0NLVDJTajRO?=
 =?utf-8?B?a3BBRGtxRnkrM2lJVDY2c0RTME4rYTZXRzVlRTV6VnhseVhSREh2bWpTR0xn?=
 =?utf-8?B?QXpBc3d3aGtmSlJXLzhCWkFObEoydnRpZ2FGVEtzR09QWnlOdWZwcWlBMWZR?=
 =?utf-8?B?SGp0Qld6SXVrQ0FPRU9iOTEzQ0ROVm1KQU1KVjJvbjk3THFmRk1mTm1CYmMv?=
 =?utf-8?B?b1Q0RG9peUZSQ0pYNmp3NVdLLy8wenlNbTkzc1hGbW5Cblc2K1ptd2JML3lV?=
 =?utf-8?B?R3pOTkV4djdrV3RuWjZSc01sREhFWno2V0g5VXJ4S1M0bjRMNlRvT0I3Zkwy?=
 =?utf-8?B?bERVMStDY0w1Vy9pMzQrdGRBL0kyZGR6SXNqNWtZKzRDckU0T0NYclZ5Qmk4?=
 =?utf-8?B?TFhVeGdnZG5NaXc2Wk5iRmtKVVJZVUxzWW5nd0VaMkNSR25ZNFpmS2NzS3da?=
 =?utf-8?B?VFkxVlNCZnpUZmRiSUhDcXhTZXpleVd0cGQvT1d0UDlqWjg1cVN3S2hEU2hU?=
 =?utf-8?B?RGNJaHMzRGpaWlREUVZwT3F2QzhnZC9LTUM1NW5zb0xPNG4vYVh0K2p2ZTZL?=
 =?utf-8?B?OHRiY1plelBPSitvdUUwN1NFYWs0Yzhid1lzZU92d0ZLV2tYbUVzK2dVYTZi?=
 =?utf-8?B?UmlJT0dSeWdiaU9ERExqT1ZMUGMxT3Y1WjFHMDl0U0IxOElISU83SExsQ1dS?=
 =?utf-8?B?eFQ3TUYyQXcwNHpCc1U0d05BWm4wcVZJVTVpcDBGZnpNdWg2ay9qd3R2ZTQ5?=
 =?utf-8?B?TGdINE5LZWFjRkNLaS9QeUhTdlViMmhmSjNyOFdxUXhyR0ZIdzI0NEV3SXMz?=
 =?utf-8?B?VVJCdzl3WGtTWFgxdHlTeThWM0hCTXFuaU9DWDlQbnQzTEJxYlpqMWR3TlZa?=
 =?utf-8?B?c3JNaVZucWdTb3dXQzBCdW9xM3ZLTjZhMm5hMExKOVEwdmhlSUN0ZGkreW91?=
 =?utf-8?B?SE9XWFYybkVPZnVnRFhmd2IrcUtKWGFPN01vZ3h1U3hzcDY5bFlpcTFrNlls?=
 =?utf-8?B?dWVXWE0xdkhmcUNNc0pCSFFydDE1eSt1NnFsOWRPalF2QkcrSS9NY0NObVJL?=
 =?utf-8?B?TTNlcUtjSHF2eDBoMjlmeFpZYXNLVFovZlpOcTZqODFIdVVhb1cwM1dGZ2R4?=
 =?utf-8?B?aWFnYXNaTG81TFlnZm5KT1JOYTV5TVF4azdmMUlhUnd1UEIxb2hYM0kyWDJL?=
 =?utf-8?B?bW0vU1hneG01dkpwdTJ1bTY5T2l3RWNaeEppUVlvQXhrQlZCWFFUbElzUDhI?=
 =?utf-8?B?TVJiSStIQXF2WXdWZ0sxUEpuZzZjVEw0ak9yNE9ldmo3eDNRUktvVnY4akZU?=
 =?utf-8?Q?x0ekKoNX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb904966-81ef-41fe-46d9-08dbcf0ab17b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:15:03.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jihJX6nfN7s2h0JKMbJx15FwmA28IDjmdOlBWHTh3Qg4uM/26gokEK6/Ri7LiS0xOGZ1/8U8QivfAslOBf0O/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170103
X-Proofpoint-ORIG-GUID: hlx4ZlICf0UbzLah4zQqIKkS49czGibZ
X-Proofpoint-GUID: hlx4ZlICf0UbzLah4zQqIKkS49czGibZ
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/10/2023 11:37, Masahiro Yamada wrote:
> scripts/pahole-flags.sh is executed so many times.
> 
> You can check how many times it is invoked during the build, as follows:
> 
>   $ cat <<EOF >> scripts/pahole-flags.sh
>   > echo "scripts/pahole-flags.sh was executed" >&2
>   > EOF
> 
>   $ make -s
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>   scripts/pahole-flags.sh was executed
>     [ lots of repeated lines suppressed... ]
> 
> This scripts is exectuted more than 20 times during the kernel build
> because PAHOLE_FLAGS is a recursively expanded variable and exported
> to sub-processes.
> 
> With the GNU Make >= 4.4, it is executed more than 60 times because
> exported variables are also passed to other $(shell ) invocations.
> Without careful coding, it is known to cause an exponential fork
> explosion. [1]
> 
> The use of $(shell ) in an exported recursive variable is likely wrong
> because $(shell ) is always evaluated due to the 'export' keyword, and
> the evaluation can occur multiple times by the nature of recursive
> variables.
> 
> Convert the shell script to a Makefile, which is included only when
> CONFIG_DEBUG_INFO_BTF=y.
> 
> [1]: https://savannah.gnu.org/bugs/index.php?64746
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Looks like a neat change to me. I tested with CONFIG_DEBUG_INFO_BTF=y
builds for full kernel build and 'make M=modpath' module-only builds,
and both work well with correct pahole flags. Feel free to add
either/both of

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
> 
>  Makefile                |  4 +---
>  scripts/Makefile.btf    | 19 +++++++++++++++++++
>  scripts/pahole-flags.sh | 30 ------------------------------
>  3 files changed, 20 insertions(+), 33 deletions(-)
>  create mode 100644 scripts/Makefile.btf
>  delete mode 100755 scripts/pahole-flags.sh
> 
> diff --git a/Makefile b/Makefile
> index fed9a6cc3665..eaddec67e5e1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -513,8 +513,6 @@ LZ4		= lz4c
>  XZ		= xz
>  ZSTD		= zstd
>  
> -PAHOLE_FLAGS	= $(shell PAHOLE=$(PAHOLE) $(srctree)/scripts/pahole-flags.sh)
> -
>  CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
>  		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
>  NOSTDINC_FLAGS :=
> @@ -605,7 +603,6 @@ export KBUILD_RUSTFLAGS RUSTFLAGS_KERNEL RUSTFLAGS_MODULE
>  export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
>  export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_RUSTFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL KBUILD_RUSTFLAGS_KERNEL
> -export PAHOLE_FLAGS
>  
>  # Files to ignore in find ... statements
>  
> @@ -1002,6 +999,7 @@ KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  # include additional Makefiles when needed
>  include-y			:= scripts/Makefile.extrawarn
>  include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
> +include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
>  include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
>  include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
>  include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> new file mode 100644
> index 000000000000..82377e470aed
> --- /dev/null
> +++ b/scripts/Makefile.btf
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +pahole-ver := $(CONFIG_PAHOLE_VERSION)
> +pahole-flags-y :=
> +
> +# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> +ifeq ($(call test-le, $(pahole-ver), 121),y)
> +pahole-flags-$(call test-ge, $(pahole-ver), 118)	+= --skip_encoding_btf_vars
> +endif
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
> +
> +pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
> +
> +export PAHOLE_FLAGS := $(pahole-flags-y)
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> deleted file mode 100755
> index 728d55190d97..000000000000
> --- a/scripts/pahole-flags.sh
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -extra_paholeopt=
> -
> -if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -	exit 0
> -fi
> -
> -pahole_ver=$($(dirname $0)/pahole-version.sh ${PAHOLE})
> -
> -if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
> -	# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> -	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
> -fi
> -if [ "${pahole_ver}" -ge "121" ]; then
> -	extra_paholeopt="${extra_paholeopt} --btf_gen_floats"
> -fi
> -if [ "${pahole_ver}" -ge "122" ]; then
> -	extra_paholeopt="${extra_paholeopt} -j"
> -fi
> -if [ "${pahole_ver}" -ge "124" ]; then
> -	# see PAHOLE_HAS_LANG_EXCLUDE
> -	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> -fi
> -if [ "${pahole_ver}" -ge "125" ]; then
> -	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> -fi
> -
> -echo ${extra_paholeopt}

