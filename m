Return-Path: <bpf+bounces-38206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B909E96188C
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D6F1F24AE8
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8700B185B77;
	Tue, 27 Aug 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mj7a43ps"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBB537F5;
	Tue, 27 Aug 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790808; cv=fail; b=YzTZo8zG5O0cer0lV9W9hhHcHJizM1mEGDufnpPfkrZwi6Aeqkbg/dM6WIuRmUwor/nJKPrmCm3TeQuN7tYJJ+8q9qgs5A2VzJGVTludt5iUacfxj1vJ0mW3h7FY/QlFIL3sUsl7hqTzzjjxE7AUpjB4L1kEuby/6lkGvZUfbT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790808; c=relaxed/simple;
	bh=K3xwLn2yNA+QyFN8T45obqladFNw4tif751WqI/dUqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSwbTU6bsXI1rtTOVHotYd1Q5VWeLYYFAcSM/IhzwRrprLPr+rLpU1MZ6B1cMXfFlcZvGaMf1TedzK++P1iFvjbo62CL0Rjdoudkc/J7s65+LDNsviH1x5ALk358QcgeUminA68mnKikQV1Wmj74bR3UmfJTRvWtO4cgdWkd6a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mj7a43ps; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RI03i0011096;
	Tue, 27 Aug 2024 13:32:27 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 419kpprgp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 13:32:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z332faPNSgktV6Xt6M+/pMFlGw5sHHXWQLfrtUMkeYJr7Qp6u1ctynaPelllDzP2hHjg+7hI0bdU+JCp88fj0WjnuNdeZq/Hz4pkgXxscKsPqI6CspaptN47GiWNP2923mL9U6QoBR2DKMu6sQKeLcACg/9wxCBJc8EBdBbrRCtCWsyhiddQ7fzzV3kjYMa3qw7ialbXKCcXFxmiThqVyM/JjHPVxLd3dN1+8Pk1VLAm+TckWJDI5KnfW1WOrXyoO9cPvOLgySMHkHQy/ap5xsWq2Wbfsv0Umx8VC/Pa+Xxifpthy11VAvGqaAGsv/9ZOW4wiYKEgWyOg3+sYx2ipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5jeZhYvpAA1HKEQ+EGbLFu3Q0EEOU2dn7PpM51VDVw=;
 b=I+WOPbCIR41wpa6wD7QZFM/5rVsgV4OQyTTpAH2fLYlKU96dunExXOFuAwCpaMa7sFyeyl7zJJ1289tr5wlrOiJvBsCyY34xf3nUmxezi6X9bw3n1lkbHmIMjK9ycVKM5BLNJzmek0qVVoddF80z/xxwc8OJDBPXCNejxU+Wy0HEkDyjGWWSZ03IJtAYJg1/cxOdB9ZY/liudosaTOFa5ayMz3LZbmwN0IILGyas98fVyq3W2ODygnCVwwWPEqjFzr3cmirY6SeGWt1/sXLhPWNbDXWyiWHAHbDRRObQsfS0ngl+UWr0jsK/yY6h1m0knGaosaFPu5lKd1vHkf1b4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5jeZhYvpAA1HKEQ+EGbLFu3Q0EEOU2dn7PpM51VDVw=;
 b=Mj7a43psFyEu1RuHKjloZjym4FKQjL3zrRqIu57KwnClAK/dG7/3lT3m3RBRQS9hLuRgnIo0CT6NHMK+ChNgHCNOwPNyn9nRl5cElhXbzDmNH8DUbY65HpOFVwX2HGDPpygVNQqavczWkXRn/Fb0EopGJYAe4cMgO3dWC3uSdC4=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by IA2PR18MB5977.namprd18.prod.outlook.com (2603:10b6:208:4ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 20:32:24 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 20:32:24 +0000
Message-ID: <8f104127-c140-4b05-830e-80c34617b629@marvell.com>
Date: Wed, 28 Aug 2024 02:02:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 4/5] net: stmmac: Add PCI driver support for
 BCM8958x
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, fancer.lancer@gmail.com,
        rmk+kernel@armlinux.org.uk, ahalaney@redhat.com,
        xiaolei.wang@windriver.com, rohan.g.thomas@intel.com,
        Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org,
        florian.fainelli@broadcom.com
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com>
 <5f7a617e-a8a2-40ca-a54a-19e58d69ab33@marvell.com>
 <CAMdnO-+ZKyoPY=ZDO8cir5T8hcF-nLRhkasfykF8EFbbedqXFg@mail.gmail.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <CAMdnO-+ZKyoPY=ZDO8cir5T8hcF-nLRhkasfykF8EFbbedqXFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0226.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::9) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|IA2PR18MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e37a10-84e4-4bd8-5152-08dcc6d75be7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3JMSU9NVnNVNkZENmRBTmlwNGxsbkRCN3RhUnBnd0Z5RU9VQnRFcVRMcC9h?=
 =?utf-8?B?WHduS2Z5Sm4yV05FWFlrNlRNV29QWVozM2VuTGRQSkRuY0Z0ay8vY3VhWFdV?=
 =?utf-8?B?c3ZsR0ZHY0tGM3BVRkdTamtWZXJUcWVjdUZLUzhlN0k3OEMzYUNFVGlHT0h1?=
 =?utf-8?B?R2hTNGZNTDZjajF4bjJzelB3OEhtc0lCblM3M2ZLaFlJalZUSkNUVGtnanhD?=
 =?utf-8?B?M3FDTU5weC9pbnZSVnJldkNOK3F1Z2VnUHNlbDBDbXVBL1ZHOEgwSFBzSXFr?=
 =?utf-8?B?eGc5SlRESUp6WUZaeU5INm5NbnIvenVzbEFDeEhtZndhV05xTG1QUHNOeG05?=
 =?utf-8?B?RnVvQTVlckp5cFdZRUZOSFVLQjdaZUJKeGdBL09uQzlFY2hVcEZtWlBrb1hX?=
 =?utf-8?B?aE1VcDRUdDBrNndmTUFjUy9JTXJUSm0wS1FoRjdaS0tXNjRCMUMwcW5sRTdx?=
 =?utf-8?B?bU5HWE5FaVdTaSs2aW9EUVBYS1I2WmU2MnBpL0VneUMwd093UjgyOVBObEJa?=
 =?utf-8?B?UjVDUnVublpWKzR1NHlnOHY3eHAvMGpKbUxCYjJPeDhoZEFsRE1LVHJmbC9E?=
 =?utf-8?B?K1FQMEs2OUZYayt1ZHNXdk1qTS84VHNIMnJQc3dTREpnc0NscGRDTHRFYzJ3?=
 =?utf-8?B?TGZXN2FwbWlXUEJ0VzZLWCtVUG85N09vUStQNUI5OGlnWjd4ZS94N1hGZm5H?=
 =?utf-8?B?V0hiTXB2Wk9BUDkrdm0xU2k2Sy9QVGc2OUhWYzZsZ3NNV0FhUXJRNjRDZU4x?=
 =?utf-8?B?MGYxbXBiWm5hR3EwOGFla2dGRDMvdmtTQmxrY0Uzb2NHUFlrdzdzRG83d3JG?=
 =?utf-8?B?ZEkzZkpvdWhmNFByRTRyYnZwTHY4Z250WC9KZ1R2SEwrdi9sdlJIL3dIcHpY?=
 =?utf-8?B?NmhtN3RBWklveWtORE0rZDk3Vng3MHNiOXdaY3EzdFFJRHpvVTE1SURWMWNp?=
 =?utf-8?B?YmpTYlVNeGZNZUVMUExuVjBHeFA0ays0b1FVZ1B5bUlESkE0Z3hVU1c2dHl3?=
 =?utf-8?B?T1hLbHRnSE5obVZFNmtNTWJYT2dsRWFWZHFkQWxKY09GUFJLNmlyQ0plem96?=
 =?utf-8?B?aHVRMkpWY2hIeUU4Vm93RE1OYlVYUXdLWmdLUHduY2dkSHJLRjdBYWlYNW1z?=
 =?utf-8?B?SGZhTGJLMEllY0ZMQjI1YjlCSWNLUThXUUgxTVBtNDR3YVhCMTVOS2ZXVG5p?=
 =?utf-8?B?a1kxZWJWMmRzUCtQcytMTnhRUm1QdkZMTnZrbnNQeWx3RFg2b0VpMGk2WmdV?=
 =?utf-8?B?V09lVUtPMjdjOENJZlFNRmVqS2QxVjNOM0x3dys3ekpLaENFcENocTM5cmNS?=
 =?utf-8?B?Z20vbDcvMEtaVjVkQkcwTGM2VHpscVRxMDY4ejNsd29DYWJVZGtxcE10bVo4?=
 =?utf-8?B?QWEwTTlraTRBOXpJRmdsaENrNnJiNVNTRW9HNTNxaGJlOGhCdGYyTmRKUzgr?=
 =?utf-8?B?VzlwVzBZWktmWmVSRDQzMGR6OHFRQzNpNVptd0Z1OVBJZkpvbFFFWFRrNkRH?=
 =?utf-8?B?UTJ1cE03blFWWGpEREtlNW9vNzYzMEY1c0h3WVNmSTFCeFY1b0RUa0s2OFo0?=
 =?utf-8?B?SjNxK21qV0w5UlprRUI5N0UxWE05em91UUd4dGpmWE8yQWdqOVY2cHJ3ZkpK?=
 =?utf-8?B?NGJQSmdQbjFYK1RndzRNL2QrYlptdkhPRUpCcWJHdS9lRHZnRDkwb0h3WnBa?=
 =?utf-8?B?R00rL2VUTG45V1h1YmVqdmZXWFU5dFZoVGM4OUNSdGRGbEhSMVVaRis2Y2c2?=
 =?utf-8?Q?pNL72C3HshtjCMZDjM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkZUY2hqNFFvUUM4SlgyenE0L1NXcW9VTHBXak9wb3hnQ1FQVVAzTk9HZ2kx?=
 =?utf-8?B?WTFSRFpPS3kxLy9YWm4yYTMxQ3BKT01PZXFSNENVQ01tT3RZVCtQYUZBQStO?=
 =?utf-8?B?UXQrWCtxS01tMlVXMjE5M1RMaEJEV1BjWHBNRWdoOW8ycHdlTEIwMWJnY3BF?=
 =?utf-8?B?UmFMcE42SEVmSG94ekh4bkV3SHV1enE3SUorSXZxeFpvc3Jya0Eyek01VWRR?=
 =?utf-8?B?by9xdDJmTktZMVN6YTJxMEpYNEp5bm1aZHhuaHR3eFI2NGNBMnFPckJzK2JB?=
 =?utf-8?B?RWVPL0RSUjF1eDlEbVRCU2t0SVozdWdpa2JadW1sZzRZQ2ZCYkVCMndHZXd0?=
 =?utf-8?B?c1VhcjdCaTk4TEpHYzZ2ZkJ4YzNGR2lOaEF2WnRDYU9hZTMwUmlrY1gweGd3?=
 =?utf-8?B?cElmOEVnR0hQRFRmc2RuckV5WE93TWxjMFlpWGI4V2lGdkVVU1FpcEJoSUNS?=
 =?utf-8?B?ZU5xL3I3WHdLWFVrS2wzWUgvMnFqRzZXZXFGZDBWd0QxcG5EdlhXdUdTd0pQ?=
 =?utf-8?B?YjlYeXEwanJIR0ZZSjFiakd5MURQcjcraFJDQ1FPYlJlR2VyYTBHQzZhdDAw?=
 =?utf-8?B?WE53TFZuSzc0NjB6U0gxQXJKeUV5Mm5zdVVrbkZpYWtFY2NEemd2T3lnUS9u?=
 =?utf-8?B?MG1Hbk12YVZPUFphUGNwVUQ2N01ueFpJNVhYaStsRnV6SHo3SjBOZDJaL1lh?=
 =?utf-8?B?Zk85YVpYM1prZ2crK1YyR3RudFJ1SXQ4MExlN2RlR2NFRUJDZTdDMENUTVhX?=
 =?utf-8?B?MkpuR0NWdjFaazhxcDBUNjNoTUhTTWxURFZtY1NlNExMc1BsQmRoVERIblM0?=
 =?utf-8?B?RUswQmhUNi9mcmxaUnNiWmU0c0VmNFpJZkJpRWlMYWI1WmRpQ0U0NkpxVkV1?=
 =?utf-8?B?Sy85N212ZjdvMUdVL3crNUlsVUc1SjVtTkxRSXhFeHZMTm1KVXRhWTAxcGtC?=
 =?utf-8?B?djc1d0dlMGtRVmVQY1U2N2NRdmNlUXZXUUlUMmtaQ3pJeTc0YkFFZy9uSTB2?=
 =?utf-8?B?WEs0RGEvUHVmZWRId3FjelQ5QU1waFFzc201WWRzV0hNNDFXbGh3NFY0ZzhD?=
 =?utf-8?B?YU1rdWdoR1FCenJNYTd1dHFMbmRKQUwxMS9KTSttOWZlZFQxYVpCbVlIcDJl?=
 =?utf-8?B?UXpRNmQwNndnclFwUW1HaGVCcmRteWd5aGdTOW9EUFdEdkpWeVlMUHdmM0Vn?=
 =?utf-8?B?Yjh0d2E2amJpWWdRNElxcW9OQVNwZ09rcGVRcnNoWHB2RWZXT00rcWRab3oz?=
 =?utf-8?B?ZUI5WnE1SkJZK1owRFZzZHNOclVPYTR1MStnTTBEOEVWVGdKdzdJZEQzZVFk?=
 =?utf-8?B?cXNoWW9iTWVFdjhvQUtEaURUeWFGUm1HKzRENkg2UEZabXdKZXJJY1hsdW82?=
 =?utf-8?B?UndxTVQ4QTJwYkFjZVBFVTN1Uit0QU9NU1lxbUVTcUZja1Y3dnNqdXYzUU5Q?=
 =?utf-8?B?aFI1VE5rK0VCZytpeXZ0UXA0MjBrTTM1WEt1NVU4VEdKZ01TOWUxV0Uwa0JE?=
 =?utf-8?B?d1pPTVJtdnRaWEF4RURwUFZ0Y1pJVGEwTzZVd0hlbk15R1ZPd24rOWRUbVpm?=
 =?utf-8?B?Nkhqc0x6ZUFFdWRnbmtRcE5ET1E0SDN3bkFtMm1DQ3hIWjVJMFp4L0lvaFBv?=
 =?utf-8?B?Ly96d3dVMmF1blpZSjladElqQS9ibHZVS2dSR05EZzBta1lta1pMU1ZTbmxu?=
 =?utf-8?B?Qzc2SmhwMEJZZWpsZm83RHV5eWxabDYwZGtlL0tuVnV5U2NWWUNSRFFUWkFP?=
 =?utf-8?B?L1M4UW43NVpjUlZJNTJYVUdiS3BtM2t6MTlQSWcycTRKaVRCbjdTcS9kZTVM?=
 =?utf-8?B?VHNhODdBbmtDTkxKSUJlSEVQU3dTbzVFOHo3YTE1WjZPOFBiTXhSaTNmTmhZ?=
 =?utf-8?B?RmxJTngrY3ZUOGZMVVQ3S2tpdjVLSmdwcXhGOG5jRFZZTmJ4N2h4dy9oZDhR?=
 =?utf-8?B?RXAxQUhWMlJLNkVDRjRCU3EvWkZzR3dxbzhGZjg2bWtrbnlJcDZyWmtQU2tR?=
 =?utf-8?B?dkU5QTFZT1FrSGJTK2RZZXExNlZzT0xJODdqY2lteDJCbytqc01PSDE5a080?=
 =?utf-8?B?c3ZxeENiK3JKc1JGQURBT214MmpXRkg4cTlId2xFZExvRm5tWjJXenY4T2Fj?=
 =?utf-8?Q?LObHtQHliRNCYzBg2ehzAmQ+V?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e37a10-84e4-4bd8-5152-08dcc6d75be7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 20:32:24.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG5ZMVN8uHJN58DVDZ5i/YniX9Av4RnJQRB8Y2VE17qRI60xdWgIF3Nz0xVbWpnzvcOSs5AbnH0/6eAdge0/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5977
X-Proofpoint-ORIG-GUID: OtcGP1ZsnEuK3mcDQsFLNbokvX_J_4I1
X-Proofpoint-GUID: OtcGP1ZsnEuK3mcDQsFLNbokvX_J_4I1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01

Hi,
> 
> Hi Amit,
> Thanks for the review comments.
> 
> On Thu, Aug 22, 2024 at 9:35 AM Amit Singh Tomar <amitsinght@marvell.com> wrote:
>>
>> Hi,
>>
>>
>> > +{
>> > +     int ret;
>> > +     int i;
>> nit: This can be merged into single line.
> 
> Thanks, I will fix it.
> 
>> > +err_disable_msi:
>> > +     pci_free_irq_vectors(pdev);
>> > +err_disable_device:
>> > +     pci_disable_device(pdev);
>> Shouldn't pcim_iounmap_region be called here to unmap and release PCI BARs?
> 
> My understanding is that for managed API calls pcim_iomap_regions(),
> we don't need to do explicit clean up.
> Please let me know if that's not the case.
> Just realized that pci_disable_device() in cleanup is not required
> since the driver is using pcim_enable_device().
> 
You're right, I just looked into the pcim_iomap_regions(), and it seems 
to handle the cleanup process itself.
https://elixir.bootlin.com/linux/v6.10.6/source/drivers/pci/devres.c#L387

Thanks,
-Amit


