Return-Path: <bpf+bounces-2636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98465731B67
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9F51C20F02
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762ABC2F3;
	Thu, 15 Jun 2023 14:32:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413E917AAA
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 14:32:16 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0001FE5;
	Thu, 15 Jun 2023 07:32:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FENsg7012971;
	Thu, 15 Jun 2023 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=32+t7msWqbUBeNaXIM3U3X09n82QmZyAvMnSExd2wtY=;
 b=AEIm8jFrLGKUV0bjmVN/N3QKBhmEhQPzsgH6G3qm2StjL9STnCClSheeENEWg5sZCyv/
 jlSHwBxoPmkB+u5RmnL23o/gH2WdpZM0J5EnMjyvtOCw/FSGDRDVZ4SwueGGP/xAfC89
 56ALmFLY03jpPnleGo+t8VsLTk2chIQ8CtwOrHblpmWoDXac9WdR36KyVbapkDVFV8tD
 LxpILYsgZ65uI39sxOQLZ0hSMT2rgRxw5SxhiaBEbiP/KyUIMys8pK9U4rUUIxNmr35r
 XNIsYcHOJBPddcEIWVkmBnf7TF4Oz7bR8+mbXM58jc/vtSv6viR0EIpdkqPMZx0KQRig ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu235j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jun 2023 14:31:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35FDN0JU033704;
	Thu, 15 Jun 2023 14:31:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm70u88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jun 2023 14:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vua12TbtszxGkPcRCGYkfj8Lr9qsuoJAcJ6pTNsubI4eqI3K+uWRWMFF+Ku3Rvs/e0TfXvl8xJRlv5U/ZvYeX6hdIM3PkwDZ2ELq5KLFDqicCjbKpfcEOBn7fMe7zEbdog4IE9yjky8fywqivsqg2PaGfvGRdEb/CUMaOkSPVqm+IfGxEW2TXgh434WaS+THXZXE+QrYJac20hJNtV81jr7M9LmulF5XSf0c/IYszJszrWVpJ1BRTe61X+uWzTDxogD4BnYWEhp4ipiUxL0PzfMIZHOA8pXDQDoP9ZY3MaE7Qzc6sZVqibKIMh+zsghYZN35b4nkiEw2G+B9oTwPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32+t7msWqbUBeNaXIM3U3X09n82QmZyAvMnSExd2wtY=;
 b=OoD6ivgC4mlkWzgf9CaC1aNRJNuDMzLYcJE3yKUxXU70A7S7UiSvUV9FPYW20CKar9piocey/gbTRoTZsUFuTcMcJVUnOkaVVx2QCFW8g8g16aLmWeUuWcQyfCOSB9WuU5v0CoP5wLnUkUCLabdfDQ1LXt3SnOPQG5/qOyBq7nZnG3vt+aJI72W9i00ht48PgGGGABHyWM+AnLur1P7ivnEc5cxPEa0GbS2/mLU0JfqiGapofMzDrMmRvCZJ1nU7hHciUcjNHUYLqEno8lKlppK/GOFvi4kxwPqXb+ZZaUHQgddDr1YIFBwp1USTS7lFNdPdFk5jmG8RnHDuxZHsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32+t7msWqbUBeNaXIM3U3X09n82QmZyAvMnSExd2wtY=;
 b=eFCkVK1yXCMB5UPTjFv5T4ZduufwE6Pfs42NNdP31lptMMPR7tt8ZaxJ5bYwOukq2Oyjow8QtMDkcd8SpW30Bu3NxpRWJCp0HHePrgmd0KSep6V4uRtF/PQEy3M6BiJaDwCMXFLrCKXlG8xCuOCaDcgDouZdeRllF7nVP/JbQ30=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:31:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 14:31:54 +0000
Message-ID: <6b26dfef-016c-43df-07f5-c2f88157d1dc@oracle.com>
Date: Thu, 15 Jun 2023 15:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: ppc64le vmlinuz is huge when building with BTF
Content-Language: en-GB
To: Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
References: <ZIqGSJDaZObKjLnN@codewreck.org> <ZIrONqGJeATpbg3Y@krava>
 <ZIr7aaVpOaP8HjbZ@codewreck.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZIr7aaVpOaP8HjbZ@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0559.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BY5PR10MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: b19d7f57-b924-4585-27d6-08db6dad443b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+E8lRXkQO4xKaj5o+9Aw/kBXzs/Gt6z7jNeSYn0Y9mZCaNHlv+XK/5FohVD9etO5hHshFOJY1dF7d64M7Fc+RuOYaSw9xVtkTBW4YVLynJKX4sn5rDyoXtMhVIMGcih+UJbd5N0JxLXti7oA2Aqwlgy59wrmu4aH5G8CTmc6RogwTIJqzxuhA+BKuUCErtEWPtEeLI4X3P+xiGDuzXZUuY7LlBDK2h3jq2PAsmUfWsUFKhExKKt/1po60TPPKzJ6TmCk4/dFvQN35REIAA3SggO2cfGusffvDij6FVod4L5cTQZSTAb6Ee51xnA4XFEkgyYmZ5HHk6VPnTBEG/D5NJ12Vu1FhBhcf4Gn/zib3Bq/EJk5NqLy7YIzJe29Vi96LtPAlHsuXIC8HDCrMxrvGo4BijaFZs4CcnD7SNdqxtQRJzspIEkcMnx0/iylE2vjbfOjcXvjlahIP4DR4j9fouBBMd/JZ8XwrqOt6AHsgCmevbr62npMGDydBlJv6yShADvb3eviZje7x0FAsoGz5SB6kiZtyLg0LoJwGuzTjgKzUaQmU4MpTR8eDdWe6yg4XMvP12cpH/c20SrlWXsHDrlqnY+mEHJdE+3UFBWnkTWYmqrm6ipKYdealENv8g2DU6E+8c6lxic15ImpSIyyBSD83U5soxP7p6fbCglU2pM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(5660300002)(966005)(38100700002)(2616005)(53546011)(83380400001)(6506007)(186003)(2906002)(6512007)(44832011)(478600001)(66556008)(66946007)(66476007)(316002)(6666004)(8936002)(6486002)(8676002)(41300700001)(86362001)(31696002)(36756003)(4326008)(31686004)(110136005)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzJ6U0lhTit0UjlXa0RYMDZydWZwNDcrU2YzTlNlWlpmUmpJV3lNYTNsRzIw?=
 =?utf-8?B?UjhOclJqY0ZXUmxaeWZKLzRaRUdXOE4yMmdvZDRSdDd5TEFsVlpOd2s3clZ4?=
 =?utf-8?B?THRRL3E5WThtT2p5MXh4OGh4b0t0OUVUajR2di90S0lETDg2T3BiVXkySjJM?=
 =?utf-8?B?alNnb082SzRUY3htZGI5MmFDR2ZYSm5UYVhnbGFzRCtZdlJ6ZnJES1ExZXdS?=
 =?utf-8?B?dnJ1NmpLZjFLR3ZrRHZrQnhrcTJmM1grSTRJNVBTOW5CLzliQTdCRUluRW8z?=
 =?utf-8?B?ZmNNdmMwQUg2M2tvUjhBZ2JicnJSSnRlNEtlTy9GRDViMngvb0RrbHNBV09v?=
 =?utf-8?B?dUVCMi93VmNuRE03bldaMXp2bEVHeVJYT093QUJaaG1VNUk1QzFXZEhsTDFh?=
 =?utf-8?B?dXJpS3ZZbllSVFU1OGwrT2M2VHFPY0dOL1hLNTM1cExKNzQ0ZEQvOGhTcmJ0?=
 =?utf-8?B?bWFkSkh3UGFKZ2NpcWhhTk5nbGVlV2JoK0dmZnJoTk1UYnNxY3dRQ05NOWFP?=
 =?utf-8?B?THd2STUrdGg4YlN1Sk9BZHRpR1RPMVpUYit5K0xGRFUxYlBxb0UxTXhCMUox?=
 =?utf-8?B?UjZydXkwM0xxNTRpT0pzVTk5d05JcWVxVld4eFhqV3N6U1lNeEhEVHV2cHRD?=
 =?utf-8?B?aGtHZDhybjk2Mm8ydlNwcUFENS95WW1uTlVhblR3TnlOczhJWFBKUmNDc1g1?=
 =?utf-8?B?YlB2K0pleEI1L2E1RzNSWFZjaDVqUitLM1BnOWx6NGtwc2p1R2JUek5BTDE0?=
 =?utf-8?B?WnZ5WFBKaDZLN2lXMG1EWjFPV3J0U0dkangrMGlobUhFZFMyQXBWOEJCdUtQ?=
 =?utf-8?B?SUV6YVBuVGJTZWJoWk8vVnd6TXJaWFJOcXFEd1dXc3Y1Sk90YlVnV3k3d3VK?=
 =?utf-8?B?QXFrZU1hKzA0Nm1FbmxzWWpIeGNVY0V1andwN0NaZEpVZzhzakljUWNsUFNw?=
 =?utf-8?B?MWZXR29zODRNdHZaU3hRZ0VkK1ZaSG5nMEdTSTdvN0Q3Q05LcmtVMHV1dTgx?=
 =?utf-8?B?cU1Nak5mL0ZOOEd2RmxLL0F6djQ4cVFZRGg5Q2JvUTR2WEpHZlRJc0hmUXUx?=
 =?utf-8?B?c0N1RDQraXRhWjFDT0gwbXhSMlNLUDM4cGhVYWVVV3g5aGRXb0JtNXZrbVk4?=
 =?utf-8?B?OVRiUjBUdDhzbVlYbVZKUzFMVXg5bHg5WUw5WmJuWGQxTEdCckh5UnBTYkxE?=
 =?utf-8?B?SWdKTktvUGtGSlNET3hDZUZSbHpWWlptdHJBNEMzZlhhYjAzM0hybk55RDZz?=
 =?utf-8?B?d1RNQlMxbExNTTZDV2VzMXVyeUNOblY0UXFyN0ZqU2lub0JqRzlDc3dscjB0?=
 =?utf-8?B?WUJSWkp0SVEvdHFoQ1BqT1QwUnZoNXZmVVRDdlp4eXJlMDExSHpKTm5uaWVI?=
 =?utf-8?B?VURJRFk4cXB1N1lhd3F3Q1BjVExQKzNsSjVwcEtGWDRrcUVQR1NPUXJlYkJr?=
 =?utf-8?B?Zkg1MUdxb2owSzZ0STJPQXlBMThyQldabGk4WUcrOWRiTGUrOVB4RTFJWGsx?=
 =?utf-8?B?dHVKMHRUa2F3Q2dmRndydWkvRS9CakxLZTZTSXZlRENYWTZGRGQ5V2J4T0xW?=
 =?utf-8?B?VzU4OTQrUXFhVWRSRG5LMHRsTUoyRTNoNU0rZUN2Ty9pL1Ywb3lhTSt0U1lW?=
 =?utf-8?B?TXpkZEhGTHhoMng1cEVPdkJXdWNwQVAwT3dxZTdXNFBzd2RQZnpkSXlUTzlW?=
 =?utf-8?B?RVB4Sit2d0ZoVjZFSkR6VUl2bmFxUENhN0RvckJYV2xiV1AyeHFvTHBGZTJr?=
 =?utf-8?B?OWQ1TndDdmlsd2ZLdTJhQTZ5eHU2azdtNmkrS3dDeHU1L21JbUhqSXVTc3lm?=
 =?utf-8?B?WkFaTnNFalZPeU9mYzZDbU92L1ZOMHQ4dllDUUM0VG9EK2xGbjVsZVRERUxN?=
 =?utf-8?B?RXMyTWs4VnpWZ1hEMXhPUXlnU3o0blBuNkNYMldrdDFMejA3cFoxdzUrS0JK?=
 =?utf-8?B?WjhjckVOdUNGRXk1MUUrTURUQ1RTSDlFOFdPekdwUEV4OHJCNXoveU13OElt?=
 =?utf-8?B?MjQxejdveTdJRVVRR0xZTWJpbE9id0R3Q0JZeG5Nb3hONXU3SC9sUjluUWdu?=
 =?utf-8?B?cDFGWW5lV1pwQVYxTHVEMHBEUkQwNXJpQlFaOXYxMnNVamxkY1pnYVQvYlBD?=
 =?utf-8?B?ekVidmw2YmlHWVlnRGJnNDhTeTFiS2RFU0I2YjRqMTFvWFl6UW00c0N2UEpu?=
 =?utf-8?Q?1z20rM1VhV0YxNkJZSNtv7c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gc3hN17sm/QO916IK25ooxrJrfX9254xpGk6YJP0pKksgfEZvVBOX6TjBJHfikmAkmO7dwYwakH/hfTR2YtM0e2+qE820zkDS6qIgAwHzYDRlB/8IYOSIocpPG3Nc5OZJ/P34EvHGoh6wXTTmvT1tvTY1+WFIyVV317tWULRN8ABqaYENJF21lrEowOiccQi0RYNlOboEqvPgdzrn8GTnS9jAc7zmofQkfZDTpimdikRaKRelf29G+6+F1SqxQZG4F+b9RluX0DUJYh1zLQaseofdj/XuqzF3FEiNFX4kPOPs5qG67CcQ2JqwoiAboCXZ0g4l2sGhVULsj51x7m6VwZG2JhUP7361HcluIHhAGvBO+IBh+7KQlodbIrvZjxjNml/uEmck+lu45glvkvsevLKp1MQcGnxVHUFILHu9xI6dK5yi7s3RP1dADNHKjhbrXePXrt3k/xx3ftQ595LeHwhrDU0ePPb2fnbpDSRbRPFMoTa5hfwP8jbcn/MY8Mdwl/D0+k9XqGoqYXPDOnmACY1sqF63Js3RWNSYixPEE3sKGvFFDcWd5x5N9vSRAyM6WjEDLTlYMwVjK1tsAhpCkNnWuB/p6AxLm+Q1F4EFo16RrC0gsffPvksqToPwyq1xGK93teMALgyQxCCn21AhgFLkmtnUUEEZRBpdnyE2dTPEVX6fZvaOQBgGOwgIc4Wkk0MpssGAqBTGLSNu4dAz/dw/YuB7WqKp6ykNnW5iTNp3o9Mq8NtArvv7naRi+dRVzQWWD8//DRQyw++tl9aNnLYpuBWH/raIr43W1bMrIp4tKm3B1T9CaimE5L0o+ho/zHqbaR59FyabjLKm1GqxjXHSq80pl2ocTwN0a2IHOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19d7f57-b924-4585-27d6-08db6dad443b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 14:31:54.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LotnNXcWiZZFAqZVxBzy+k6EZ+zcnlxnrbzvN5KdTc3aDZm9859L3ZDiaX3tGdDt3tQW4v4KneKbL0GlHqsc7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_10,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=984 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150126
X-Proofpoint-GUID: uLUaVhWqOtfkKijZSElq1HRu_SWlr7lO
X-Proofpoint-ORIG-GUID: uLUaVhWqOtfkKijZSElq1HRu_SWlr7lO
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 15/06/2023 12:52, Dominique Martinet wrote:
> Jiri Olsa wrote on Thu, Jun 15, 2023 at 10:39:18AM +0200:
>>> coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12563
>>
>> it's probably burried somewhere in that discussion, but do you have
>> kernel version (or commit) where that increase happened?
> 
> Unfortunately not -- we've just tried on the 6.1.33 that's the current
> alpine lts kernel, but I cannot say since when this started because
> we've just enabled BTF recently.
> 
> Alpine also doesn't seem to keep old versions of apk files on its
> mirrors so while it probably has been happening since it got enabled I
> don't know how to check, and the commit enabling BTF has been done
> without a MR so there's no test log that'd allow seeing the package size
> either :/
> 
>> also link for used config would be great
> 
> alpine has two configs which both exhibit the issue (raw file link on
> commit before removing BTF):
> https://gitlab.alpinelinux.org/alpine/aports/-/raw/749ee7117e1437b7ab3ef2590f7f2e3558fda3ef/main/linux-lts/virt.ppc64le.config
> Size difference for linux-virt: 219 MiB -> 47 MiB
> https://gitlab.alpinelinux.org/alpine/aports/-/raw/749ee7117e1437b7ab3ef2590f7f2e3558fda3ef/main/linux-lts/lts.ppc64le.config
> Size difference for linux-lts: 306 MiB -> 74 MiB
>

I took a look (gunzip'ed and tar-extracted the apk to get the
vmlinuz-lts file) and the BTF looks reasonable size-wise:

$ objdump -h vmlinuz-lts
...

 13 .BTF          003d64cc  c000000001400844  0000000001400844  01410844
 2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 14 .BTF_ids      00000248  c0000000017d6d10  00000000017d6d10  017e6d10
 2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA

So BTF is ~4MB if I'm reading the above right.

However the problem I suspect is this:

 51 .debug_info   0a488b55  0000000000000000  0000000000000000  026f8d20
 2**0
                  CONTENTS, READONLY, DEBUGGING
 52 .debug_abbrev 004d66f0  0000000000000000  0000000000000000  0cb81875
 2**0
                  CONTENTS, READONLY, DEBUGGING
 53 .debug_line   019192f6  0000000000000000  0000000000000000  0d057f65
 2**0
                  CONTENTS, READONLY, DEBUGGING
 54 .debug_frame  002d4fe0  0000000000000000  0000000000000000  0e971260
 2**3
                  CONTENTS, READONLY, DEBUGGING
 55 .debug_str    00390822  0000000000000000  0000000000000000  0ec46240
 2**0
                  CONTENTS, READONLY, DEBUGGING
 56 .debug_line_str 00000445  0000000000000000  0000000000000000
0efd6a62  2**0
                  CONTENTS, READONLY, DEBUGGING
 57 .debug_loclists 0176a32c  0000000000000000  0000000000000000
0efd6ea7  2**0
                  CONTENTS, READONLY, DEBUGGING
 58 .debug_rnglists 00382d7a  0000000000000000  0000000000000000
107411d3  2**0
                  CONTENTS, READONLY, DEBUGGING

The debug info hasn't been stripped, so I suspect the packaging spec
file or equivalent - in perhaps trying to preserve the .BTF section -
is preserving debug info too. DWARF needs to be there at BTF
generation time in vmlinux but is usually stripped for non-debug
packages.

FYI we're aiming to make BTF module-loadable via CONFIG_DEBUG_INFO_BTF=m
in the future, I'm hoping to get an RFC patch out for that soon once
other BTF-related issues are sorted. Hope this helps

Alan

