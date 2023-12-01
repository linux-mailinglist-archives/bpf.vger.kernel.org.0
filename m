Return-Path: <bpf+bounces-16403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233F8010AA
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A96E1C20E8F
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BC44D113;
	Fri,  1 Dec 2023 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JQrUHp8a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dBhc0rEa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F09A
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 09:01:09 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1Gb4U6011665
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 17:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=cIxrZ6VAdOzLoQ7phWBDhV8AITnl0xiCMPbO1V2iC2M=;
 b=JQrUHp8aYZwS6pG0/WEgkgO30mZ7PRJiC/19YQO/AT1PHtQ2Q/kBInWhllHccWGlvsVo
 f8d9eqGSeACExMhZzYQ3mOKOtlpalRTIMwvaI/zwyzscX1b12XRIFMBeQryAobj4sqVy
 SB1aYB+dXiptwRSCzRedqTUekOVH5DRWes6jHo5OYkED23EdWDgyQ6rytWosrmSfXxAG
 D0j3uU5v5adn1PKCw40SBWLdP2nD4eBzYyl2c/6XGxHg+xZh2r6tRHwIU+K1biDRbyBt
 7bgz0bvazb1plTtKOIEukGnq8R6KgWrXOq6rphYTYAoCKEw5upZNukvSyM0S9exVnK5h 6g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqhg78bhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 17:01:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1FVe8E009626
	for <bpf@vger.kernel.org>; Fri, 1 Dec 2023 17:01:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cc1jx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 17:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f67q7cRAP3EMZPnOBIH0msBLcrQ27gQLXWcNpvsq6AL0n3MCLUY9U/gASlFog/b4/43U0UpM//yrH44AWWpRCJcr72qiRAp4eV9z6BkIOV1qtwXOUg3L/pDwNK3DwE+cZ28S2dXAkknKfFLN4F6pB14IDpWp/Y/djrj490FscL68uKWot3Te42bjR/77O00btmItrun2zeehOE381UgH856cbdiftTxOXnw7A4M3JRAFSGROggYwcscXsmy0FpvuE88haPonVBqmF5FENSsZk7E7Z2OgYeqWMwkAF8iJB6yXh+tHvg/K0oUOAZPbdrBHxp2gICgUUFBjiXFC7ad07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIxrZ6VAdOzLoQ7phWBDhV8AITnl0xiCMPbO1V2iC2M=;
 b=FDcKtew3TUUocRVnVj01mbqhWGhORv6SFt9aTcAK8atlMUTgXwXan6bQEPeMFy1F3lQX9KQkMPUjCSTMvjyZt3sma6l6Zbvyx24O0SLkxZis3VdzwCNOoAI6pbT8ua/DDmQh0yElQwCF8TI6GzYfeJ95ogzsgaXUl5WaCt/Bfxvu9GZaaBSyrES+6w5UpFFXAxRZ7Lt+bh3GM56pndLC+NwEVZqMBOoANtGdIIPBJ/ONhKCoOgO78ETTC3fbvzUzz+ENVaG6ozJqgfuIYS1O3hrbkaOUgZcXwQEm8gxtG2JgER4SRhlOhSA97uL8OdQHOq4Fo251c2GXjgoalGP1Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIxrZ6VAdOzLoQ7phWBDhV8AITnl0xiCMPbO1V2iC2M=;
 b=dBhc0rEaiVuF806A55kNpDAS5FxsIli+KRZB4TVeETgYeCWw4RqhBylLyRUY0dz+8GSg5kgEMPW0wOIFNFe4JCHpELbEtRQnve8zgC1d1Yaf67vK+GmIJQ04VdWAoNJyRUYBFh4JMu4r8Uq01RFhLYf/DvyX86sUZUDYxqSrWKI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Fri, 1 Dec
 2023 17:01:04 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 17:01:04 +0000
Message-ID: <f42f157b-6e52-dd4d-3d97-9b86c84c0b00@oracle.com>
Date: Fri, 1 Dec 2023 17:01:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
Subject: sock_ops: calling bpf_sock_ops_cb_flags_set() for already established
 sockets
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cb643c-67bb-4fe6-a1a9-08dbf28f1abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LuEeCiX/yqUP1x3C98oQnrUd9w74dKip1J9l/GKemHzQ6mkb2Nh0J7vA+TobhHLeDbsE0JBuMr3o1NfiCf2BvmghV10erLG46qTomotfiQNsXCuVqxy5L/bGHiBVcKtSlfxWYU9S4Ef2XC9SgoAHs9WeAOYgKmYluL1SoyVNsml3m0NHJvOyk49wVBWD6e7buQlj1/6NK+nGE1vi/rDNmWmGsPO4paFDtKemRp68t9sdv+d4ivAKm28xxyNoiDFWvvzo7hzqFy+S9SzykhRKK24MlbK7ZEgZDPptmy5yjgd0LZVU7vPK7rXvwKwWiGlj8AW9Ck5v0ICMxEDEmgiVbXZezxUGb7DvKP62yastgIdAhEo2EjfcTFgb69CZ0MNPaO6qUfFmunYXpatpdNMpcabfcKUvSs6jjSFLjvU3gR7aXAYH6jbkWI/t7RWO3FRoCz4DJkW4QLr1GKp8NFSnyWvO523/EW2m9aj/aNYv6ZE6HVFdlkQqz/bv7TdLGbyCPSUdFHYBObtdiSoj2WATfz7BWLwcXKLLa/dOBGrQsyTG98xi7sYlJSvzlJviMIDdsXISaFNPoknw76KFA1Daixq6bZ1PqrWdm40BiV0UYgpk9SpBux2PFTGbqZsF8FGxflUr91O3cLZBdgVf/i2W1Rs7NgmcSBR8cdv8RaSS/q72vUqHPfwJZKAFVtU9FSPZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(2906002)(6916009)(316002)(66476007)(66556008)(8676002)(66946007)(8936002)(41300700001)(6506007)(6666004)(6486002)(478600001)(6512007)(44832011)(31686004)(2616005)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002)(579124003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OFlWN212bmRLelhkYmUyTTNLTmFVWmc5aFN2RCs5ek9NUFFnN2xaOXFSeTJH?=
 =?utf-8?B?YzR0bmhyL3ovMTJDakZPbnhLeUFPMlhobFF6UnNEK2hqMkVUTmdWUlA0bDFM?=
 =?utf-8?B?TC9nbzFOR2NhRkNndDZoc0JjU21pNjNlQmJlTEY2MWRkNGFJN1lLaXlzd0Zk?=
 =?utf-8?B?d2lSazRUcERiZ1I3RUMvQ3Y5NEN2b1c2eVNFN1BxZlZnVlFFU2RTU2p0SGpV?=
 =?utf-8?B?OHNHU3p6SjJlSEZIRktNdUE1ZGcwbHpWWGFJRkhWWk1Wd3laWmV4UmVINXAx?=
 =?utf-8?B?SEhZQkhXY2hlMWhKYUtVd1prUHpVc1Z0VUxseFZtSzZFZllzbjh5MEpubFd3?=
 =?utf-8?B?enVubG9LZ2tNNjNrZ3lWWXgvRncyc3R0YnJjKy8vbUZWWCs2RzlJNTlxeHZL?=
 =?utf-8?B?YUtOS0xBMmpTVzF1aFhycWxLdUNnbmZxZDFiR0JWK3lETTlJbWJVRUhzWDlZ?=
 =?utf-8?B?SVBlSDZURzRPMUFoN0dsOTRYOFg3VjFHQ2pPaHZWdHloTGpKNVdVNWlUQU9o?=
 =?utf-8?B?U0g0YVFaMDN6bW9PV0ZvUCtXbjhwbGpSOFJEZGRZVjZLbWQrSVNFb3kzZHF4?=
 =?utf-8?B?LzZzZTRyUHNGanNoZXp6Q3ZXSFlOeEZ3VUhkL0ExbHNNRG1zUmQ4NW5FMmFj?=
 =?utf-8?B?TmhkZzJNaHBLZ29aUXV1RVo5NEY2c3gyV3pPa3lZU2xWQ2tLRTVtMkFqalFX?=
 =?utf-8?B?bmJpM2RKK3N4U3RxYS9jZ05uZE9EdnFWdm1lK0N1R0prNFpNNFd3a2NEblNL?=
 =?utf-8?B?WndaQ0JaNUR2QjVITWt5MG1wMThFWjBpcWNsaUJ0ZWZTVDRsd0pSUkJ0SGxt?=
 =?utf-8?B?TUhOTG1QWWZrT2FscHlzUmVIanRTVDkreit0bUpyR01zbFJ4d2t0ZHN4TnBm?=
 =?utf-8?B?WTg5enBtWE5neGtWVm1YblJJa1h5a21BUHcxK3BVWXRvUTF0RXpJTGErTlFK?=
 =?utf-8?B?Y01wclVCeVpJWTU2WWVhaW9TMXcyTU03NytnbXJETjhMUmtVMzdFZ2hId3hu?=
 =?utf-8?B?OEdjNTI0d0xrUUMvVVQwZlBZZVoyWFE3L3hEdFBpNW9rREcyZExIemNtM2dx?=
 =?utf-8?B?Wi9ha0hiM205UW11d1NLV0U0SnowQWVaSEFzbFVyMXZ1RVJXeHUyQm5CdGdt?=
 =?utf-8?B?UytGWmVoVTF6NWxycXVVWXNxZEJpaDJBdWFUdkx5TmhjeVN6STIrYitvSmpE?=
 =?utf-8?B?Zmxjc1VPZnJ3R2dtQWVyRVEzOVhxMGFtUXcrSVVlQTFna3hHTkxnUjFGdmpJ?=
 =?utf-8?B?MmcwVlBCUi9zTFhWU1BYaGVaazBKSnhUdmpkUVhqcnEwVlhRQlkrMVBuN0tU?=
 =?utf-8?B?djdrbkJJemtqZjJRN3ZYdWxmVXN3QUNGZ1FQTXB4c2w5NElVNVJCN2xjYkVR?=
 =?utf-8?B?dldUYTQ3WXhqbnNTWU8zWHpZbUdzTTEzSGVLcTY1QkxkVy9tbEc1VysyUU8r?=
 =?utf-8?B?NFVmcHhUdEVIT0FhNmtUNXBlT3R6WEFxYlVMNG5KdFFMNGhPQXlqRkhuZU1U?=
 =?utf-8?B?ZG1LVDRNcTR2K3J6ZEkwczI0VXZZZUlvTDY1NnQ1UU5iVit4ejAyK1B5Zm8y?=
 =?utf-8?B?QU9EWGRmdDN1QmR6ZjJSZmZXYU1hUzlNRlVIUEFvRzk2b0prM0N3eWgwRnJN?=
 =?utf-8?B?LytYL3NIY2JWM2VCbGtMeGE3aGVCTjhPbHFlQXlkc3lsSjM3Q2kyUGFFUnBB?=
 =?utf-8?B?SDJhWUNoMkY3b041VG5vM2NrM3BoOWZaOUNRSnhrS0lOMzFQekhxTEpWVFFm?=
 =?utf-8?B?SS9IYXlSVndYQ2xQeDBORm12TWdOcURsajlObWdjYnhFYS9aYWIzZXh6L3RX?=
 =?utf-8?B?YUJmRXRLTk9pWkdiUVFDNHpENU1kcndxNExibHBwKzg5V3NhWWNublNLYktp?=
 =?utf-8?B?clpJY0VsZUw2R01KdFBVOFJIbE1TYXFSQXpjWGdzTWJRQU5ZK1paN1B3aWtp?=
 =?utf-8?B?aHhXMnp0Mk9rWDUrcG1JM0NadDUyaE9VTzhoQng3a1N0SG9LMEpCaURQQit4?=
 =?utf-8?B?ZmtwZHZQd1FaVFJuVFN5bldMYVhucnVDVEtiOTZxZEpaRnVvUDNPNVVYakNH?=
 =?utf-8?B?N1RvUjBZdWV6ZG9UMFBDWTllUUNxclZidVBYTzZOLzhPakFCcTlqRzhtZDZP?=
 =?utf-8?B?MTlRMlY0OWpSK29seXNwVE01SDdTbURFWWRMS1NIQ3k4OW5rNFpuajNQOUVB?=
 =?utf-8?Q?yiLdJ/OtpRKXepP8OXKvok8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GyhfNJfuaxN3jIQ3WSUXs93ytkyUcjjiipaL+cNiRYdqBD0vJZp1j2YETazNIT8jsrwPi7xI04h7I3idJsawDiB+Yuc/oD+rDlNZt5+B+gejOfjn/IrKUxFN+F1E6as/8IeAgwhxxUvY6/ZCpcq/f4Zaft042j1OiQlxal220T3AdrWCB8qJApuXJQApeAdDlYQ8E+8Fk1xqq8JwtkbWdX4jXmujC8Vzm5WOKHDdNiTuXNTtjovcoj7Azrpb1eW0iOP3g7zq8BlMiq1hkZJK2+BZ1wZqK/6Ail8aQJnzTFSlj9ZmMfH+B2TjPIO7XzIysUxNzza1kedQxqkR7SODqhGO/NDAtydViBk4Lx7HavnPcBR+hcnYvEFlMIe/mC0B3AONpQW2bbDvjl25FbhxH9dS4BsVLiaJBjGUyQz09QVuA25EgLNdm9CgWao1lxmhsKYHMoDunA7SYnCiLvr/lAdybqI1uDV7rCWTLg5ntMA1xM7710FB8xfvyMqSohW0MuKond4Wqee6IUorD0mpGD+Tnxds1D5IdyuMGPPSrJGJyajkvEek4qTgh0z0tso0+VH3iodKV0Mlcy1hrRSFJyFLV9VaQLg/eB3ueu6exNHWmzo/zNGoYlJJQcaBBLVoBohgt8gAwg7BtEDzrR41f3bXJTgT1rGyG170vthG2lsxrQVoM2llmtpvO5WetDK1iQ34cb1qOhQ4DqsbAOn9DEDkPtNavfSTfnqaE+1TTtq6Nwh3J2vLCF1dzdex7xncnIm9sUG/PEYqjc96wWsJgg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cb643c-67bb-4fe6-a1a9-08dbf28f1abb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 17:01:04.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1HeOw1Ud/HhWaoG4Cs8/egM5QrqXNUjCb4Zeg6wS6Y8WR7/741xXly2IW0wARhBdtz716RUfzT+9SmKpL42pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=791 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010115
X-Proofpoint-GUID: 8Opz_pMMFBP2Tts8qptZHtT6-0SE2rFE
X-Proofpoint-ORIG-GUID: 8Opz_pMMFBP2Tts8qptZHtT6-0SE2rFE

hi folks

I've run into a few cases where users have wanted to enable additional
tcp-bpf sock_ops events for a socket _after_ connection establishment.
The problem is that to set the flags to enable additional events, we
have to be in the context of a sock_ops program, and as I understand it,
by default only events early in the socket lifetime are enabled by
default (such as connection established/accepted). As a consequence, if
we do not catch one of those early events, the sock_ops program will not
run and we miss the opportunity to enable more sock_ops events. This can
be a problem for boot-time connections like iSCSI where we are too late
to catch connection establishment.

I can see a few possibilities:

- support setting sock_ops event flags via a socket iterator. This would
mean that the user can always set per-socket flags on
already-established sockets by iterating over existing sockets,
selecting those of interest.
- supporting setting event flags via setsockopt(). In fact we wouldn't
need to fully support setting event flags via "real" setsockopt(); we
could simply use a cgroup/setsockopt program and allow
bpf_sock_ops_cb_flags_set() to run in the cgroup/setsockopt context
(with additional checks to ensure it is indeed a tcp socket).

Do either/both of these seem reasonable, or is there a better way to
tackle this? Thanks!

Alan

