Return-Path: <bpf+bounces-13427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C827D9B4C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1FDB21426
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3637163;
	Fri, 27 Oct 2023 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zUNqo0ls";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IfIj6VeA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72436B1F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 14:25:47 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C5C0
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 07:25:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUwpU013666;
	Fri, 27 Oct 2023 14:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bd1rrQv1g+MAWvUqEXSwwIdcxfexHOtUH/wr9YuPO14=;
 b=zUNqo0lsA9LX7GC/NX/RCcNSxuYt+gUwVCbkXcXxgeLbFGifMdqOchZv4jz1+oKpTrX1
 HhiXoPgSs9qOGB9Rf4Kb2n+byy4OqZQ2kX4u74jqPrTr6BwPyG6w/eHr6nvsEEM2QCjW
 8YEyQf1MTIySX27LqTJa2DELQblSD1dsO+Mws3UBb3dxzGdKsjDXzfc+Suo7a74XUKsv
 Tmedvx+4kpxT3zGD0rfL2AFhzvrgKGZ19/KMo35o2QnzaFn+64sznoOGr2zIJJYAa1RQ
 50Rvs/+R1t0JW/5rYna5pN8fvGg6MDG9Wp7e8KwjvEriamOsvoq0pGRcdjS+fRA7xvdp ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx3nhk94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Oct 2023 14:24:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDLFpY020001;
	Fri, 27 Oct 2023 14:24:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqk9qtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Oct 2023 14:24:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdwryTUfB/gudgsK0QOMwxGQ4Z0bVmegJ5NiDT109PaHkEX8b8VYvmzWFwBXwzIxyc0GTiamGuWoBiMo9z5hJ+XCqhVa21U6g6JiPo8Y6Ny9wXYvAubPpQjiggazpbyujozxH5VqzP4lVmj6o3cY3cxNg5jW30M5eJQ67gTYBr4faZTjzfp7l+hj4Sllu5G4SPMzYGfa6sTjGk+SV87tYe9tsMNZE7T8T8nbNktxtbURh22pJpYaPO0vfgAZZfR8usGCjXVWA2W6hVVozf76/78I4dFWKU2asxfjjTlKIP1hwkhhbeXsSYkvRPt07cOXdqRxIOuNEyB9NGIApMBisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd1rrQv1g+MAWvUqEXSwwIdcxfexHOtUH/wr9YuPO14=;
 b=hPPYtuDbGytzgPAG6c0N0mKy0RLet2pFEFv8+C15CwU6eIB4Du8KkzyYTufll4QOlSfzjtaYMVQDmjQGXNjUKep98UULEAawg1DR1B2XsEQyicuYqS7dtk7IAXCkITIBpVqgePxcz3wFuqhC2IPfgQDtcVSL95Zvs50CbICtnCwHDVbF0JmFqJgkgs18e9HcrpISFyzcXpBk6Or3QuCtvTxuoFBeHf1mi5GaNYybpSTMLm4Op7aJb/zUUnTbJOy7X7KjgY2w+Xf7FEb0WRDHut0AKBYKUpBo06Hp+b99cFi9VJwLcJTIR1q0bWIJ5Jsp7UQmprjQ+ejfsLhmZR8J4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd1rrQv1g+MAWvUqEXSwwIdcxfexHOtUH/wr9YuPO14=;
 b=IfIj6VeAZKI1Kzd3T6pivcTEBCSl+UTpKl/EIjv1DKxgcgJroiApRnBdd+ZlrBH2LCc2xraeLddYRBSxYSFfNWc1MDNDIcBZgdI2oaVBdkz4NY/Ep0RAEXAynrt7qgLTtmK9SmhepIuk9IHbmGcJXbUN0qEbM5gg4wj5TW5uzcc=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 14:24:50 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::357e:f629:fd19:f505]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::357e:f629:fd19:f505%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 14:24:50 +0000
Message-ID: <9ff0c24e-6ddb-9731-df23-578897fa567a@oracle.com>
Date: Fri, 27 Oct 2023 15:24:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: RCU stall issues in bpf-next (was: Re: [PATCH v4 dwarves 0/5] pahole,
 btf_encoder: support --btf_features)
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20231023095726.1179529-1-alan.maguire@oracle.com>
 <ZTlTpYYVoYL0fls7@kernel.org> <ZTlVAtFw7oKaFrvl@kernel.org>
 <ZTlaoGDkALO2h95p@kernel.org> <ZTlerFwlAn3AP+o4@kernel.org>
 <f65dd024a49323f4b0e282c1f71384b96f170d16.camel@gmail.com>
 <CAEf4BzbM20uErJ8-UiRb3WCxXJUXtvSRCKSfuAURXpsHU4ud-w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzbM20uErJ8-UiRb3WCxXJUXtvSRCKSfuAURXpsHU4ud-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0274.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::6) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|BY5PR10MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea1061a-c8a3-4b45-c289-08dbd6f87aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cq1vPGek7czZSjhdFaxBgKoI0Y8pMVXA27+dhtlCQAsOkDO8zDD0aQtoUZdZmmPNvRK/8dkU9tPlV33gx1Xoj6Mj6Wv3w3Osj52aUk9NKKqqUBG0TLwgYm0DBgut8XeSmcUyL1t6rQaoFubFYio2bDHa/ZT8dzOeoqgJM1McgDOsYYiYHpxY7o/LtXwFzJ9yWdz6w+brJ4HZCezFaFMQFZnuPsExU3rA+GJ1fPX7El/210ev35h1voAzhXShaBb79yYKaXPW16RTeRyZ1rpXSGFColixLPr20Z631Tom1yGtj28H5q7dgKDBCEWfiHHYTfULL98V4w3qrsIN/TZnu7gbe150BI5mTpLwfTuCFQck7nIEugu1aJQ/l2/xQzJ0nby35+A5mJ2ETmTtWhXpZhMOUzxv8iACfxOzXD8kVGa5C6mtzsjZO1I7qhLxIehP3yUSnc/RG1Xo722erDMGYs1xuGe3Yixj5od4FAe+uXgZ/BlvAE5p7rIuC1mFOO32bHMXYLpV16pGN13geHrgrCaxFXQr66vSuocwLdxrEXYt8RNMjnJpazvFNkvy4wEmUTVD1EhcZGuTHkYfsEq2DuIztjDIsDFmoLXnvnHHiZuWOEemQUC3VYH8y91GRH21lJqyV3O32Yz93PpXqE1RAAzCgyWd8HSo1P08dvbcUVNbvwddQ56Y9rpCSXZt7umc
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799009)(451199024)(186009)(7416002)(8936002)(5660300002)(31686004)(31696002)(4326008)(44832011)(45080400002)(8676002)(66476007)(41300700001)(66556008)(66946007)(86362001)(54906003)(110136005)(6486002)(478600001)(966005)(316002)(30864003)(2906002)(36756003)(4001150100001)(2616005)(38100700002)(83380400001)(6512007)(6506007)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEgwNHNzWjdLWjN1SVFKbDg0N2ZOMlFCT2lGQm9reFBTM0tCOC9aRjlpeHVu?=
 =?utf-8?B?V0w3b3pSWnVJakhmUzg1L1d1cDhhSFZ4MkUyaHJUMFFSN2FCRXpxTTRYRThp?=
 =?utf-8?B?WmcxTG1Xd0hZSWRGRXYyS2x4Nk5mL0VCNmpHNHVhMG9oRzNtS2p3djE5dEdC?=
 =?utf-8?B?dCtjZnVGVDV2VTlnMXJlQ29RU05Qa3U3aTBjeERXbU1uQmJweWducmhENDlZ?=
 =?utf-8?B?RlhmaWkvaENHbkpNeUtVdTRpVklDYXJta1pVNzNQTFJQcU1YMVVpUlIweGRn?=
 =?utf-8?B?Z0JWTEprendibXlRWnBZTHNyVTd5VlF2UWN2aXpzWWt0QVN1aTVOakFqaHJt?=
 =?utf-8?B?VFNJSVRhREI0Q1dIMUpWbStPYlJIYzd4aUNiOWJJTnhyc0swYmVZdlpzWkIr?=
 =?utf-8?B?MmhYdG5nc2V4WUZwaUJZS1FIaW9JSXFYTUZERkRiUTRpY3ZaaWY0eXZ1UVZC?=
 =?utf-8?B?ZGtCdCtrcWxwUzl4SnYybWc2RU1PNlVJTVBFSkZkTG5CdFlyMnlXVkVrd0t3?=
 =?utf-8?B?VlJhQVN2a0ZaRDRBTFNTYnVlVWFBSDVWRnBOZ05OVnhDRDR4YnV5OFd4d1Rx?=
 =?utf-8?B?N0VYYndaRlVVYmZ2aHRETjE5bW5FQUxYellBUmZYUk05UmNpeWNSaWU1M1Jy?=
 =?utf-8?B?Uk5BMFc4a1FES2o4d1lBZGRHcnNTYUtUUERFaXozanYzYUNTM3J2emhZY081?=
 =?utf-8?B?L29FN1J4SFpWNjNyd29YQXpjRDhFUE1TRnVTRVZnME5JaExDdDhiSEhQS1Fs?=
 =?utf-8?B?QmxLcldFMUxvYUNvcXYxbjh6bnFMaGdQbE9QdEVoSXdiemN0YXVQbGtWOGcy?=
 =?utf-8?B?VlJLakR3NjUrTys3SS9LYmpnaEZUVWNuam9HY1dCNFJVMkc5blNxanY0VmZ4?=
 =?utf-8?B?RkRWdTZFVGhwNjl1LzY3c0Y2d0xDM1lVVnJQR3JBaVlPYXlDQ2FYclpBUk50?=
 =?utf-8?B?MXJGT1JPODNENXc3bkdxSHNVRFZEd3dJNHhBYmpvTmhrNWxPNEtaTlZObVc4?=
 =?utf-8?B?QTVBbHJsOW5xcFlPUFhqbi93Q1lRUkdiN1FnYUxxTFgxME5NYUJBMC83b0Ji?=
 =?utf-8?B?ZVVvS0dLVnh1TzFtYXBjamRoaU5rVUxVL0FIanBiZ0pwcHpJYzFUb0w4ZCs1?=
 =?utf-8?B?MTdQWFIveFhiZ2FhNEt3YlF0Z3djZTVqdENIL0s3dkd1Sm1HSFJzN0JqNlAy?=
 =?utf-8?B?NmhuM1hzMHIxeE9ENmlycWE4ZTdwbGhmVkFGeXdoU3JMU21reUk2RFROcVJp?=
 =?utf-8?B?RVlXcDMxalJRMDNSM3JZUk1WallabmplOVEwSzIvaXhFOWZRMitjYTdNbjJH?=
 =?utf-8?B?UExrdzRGcE9WVEg1R1ZDTzN6d0JMZXJCMlkrYmdoN0pDRmVQREVqV3BsYmlX?=
 =?utf-8?B?cDlrVnh0ZzNROW1NeE93TzBMU1VWVUk1Y2NNTm9GR1IvdnRNak5abktWRHAv?=
 =?utf-8?B?M05MUU5rV2NGRHplaEwxcnREbXZkanlGWnd0NTlnQUR0QitLTHFtL0c5ZitL?=
 =?utf-8?B?NFBDKzduSkVKcEJiVGp1UE5MT2d2RlpiVE9PdE8xNTJSR2IyYjBaVDVQR0FF?=
 =?utf-8?B?aTlnNDVja2hkRFUxWktaNGtxMzdLaXR2WXpNNG1EbURIYXQva3FDUWdVWUds?=
 =?utf-8?B?akZ5L0Zrbk1DS0J1alUyVGYyT2V1NVNXekhra2dkSFlPYy9ld3RkVk85bXVj?=
 =?utf-8?B?ZUF3TVhMQXN1dGxYZE9oeDVVYzZKYUlCblR0R0ZwNzdQQTVpZ0JWTmYvQXI4?=
 =?utf-8?B?am9sL1EzYjYzK3hMMVFORWRkb3c5SktpQWt1TUpMNTFvL0dmZUN2UHpHMG4r?=
 =?utf-8?B?ajdkZS80dis4QS9iRWMxNmN6MnV4cGk0MkZDbXVKM1A5Z0NYVUF2bTAvYUxu?=
 =?utf-8?B?QmtBYjRxcUg1d3gzZlR3K3dEOW1kY2V6VHl4V3l1YUxqYjcrTCtGMXliMjJh?=
 =?utf-8?B?cWdsVmZmbWdtdy9jcFlycnhNbDFiczRCTU8rUkpnc0s2NVM5WkpRUmFVOFdp?=
 =?utf-8?B?WVBYVmkycXVMOFJSN3J5Ly9rTC90Z2RxVjc2VC83eTNMREJKRWNZdzBJeXYv?=
 =?utf-8?B?cHZZMnN4ZUxYb3pVUThiQ1BWbXEzN2dyWERhdnF1TGxhQkErZlR2cjBvNGNO?=
 =?utf-8?B?UitqV3RaWEgrNmo3UWo0akcrL1V2dnhrMTRzbGJvdEJldDVaSEdaMm13Kytq?=
 =?utf-8?Q?ZmmUU+TMT5zcaK/t6jJryK0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RHBkM0I0Y1pPSVFxZFpVbU5nSkp3TGt4OW43U2xRUEE3VmxYN1VIUmhFdHls?=
 =?utf-8?B?Y1RQNGx0K0xyOEtveGxSNUIrby9rZmtTeHBPNlZCYWcwOUNYV012MitpdTNo?=
 =?utf-8?B?eEpDUXJHSDRKUjlSblZVdzhPNnh4UVZhSzJLYjNtNTg1QktrMHZLMlhiZlVQ?=
 =?utf-8?B?MU5lbTV0NDJIWkd3ZVRDTXNZYWIxeXNGUXlYM3NTS2tjdlpJU29pdXcvYUpK?=
 =?utf-8?B?Ny9wOVh1ejFhK0dQZjQyZlRCNjByRjN5Q2puZm9VbXhrdE13Z085eUlDWkFM?=
 =?utf-8?B?d1lmQnUxcnBncE54ZjVXWHYxS05aaTNHa1pkWEw3VG9aWEZOanZwWHBadEZu?=
 =?utf-8?B?UmtOeEZ1bzluRXVNcXN0MytjeEllbDVYYlVJVTJIeXZNL0FSR1ErN0NrWVBG?=
 =?utf-8?B?VzA3YlVjbi90RGhFMzVKRGtUdW1xdFk3d0VlNEVHZVYxWkJVZ0FXb2JxaVNo?=
 =?utf-8?B?dDRWWUxsYTM3cXF3UStlcFJ5OEt1c01DQTIwTi9ZUkFQODdudWxSL0ZQalVH?=
 =?utf-8?B?aXN0T010YkRtNkVlcklVWnlrZEM5MCs1dHMvNUx6T2pJUTUraTJCaytGdXU2?=
 =?utf-8?B?RE5pZ1d0VmU4R1VyOHFDMjFvT1ZuTzZMaGZEQVdyeFJ5VC94MUMzMWVlOVYr?=
 =?utf-8?B?Vi80U05TaFo5eUZJLzRMaWZUcWs2Umg4dk5iZTRoRG9ic1hHM3Bhc3g4ajND?=
 =?utf-8?B?UFZFTnJ3eTNmWEZwTXR2eUxWSWJXeTJpd3FVeTBub1RQY0NnK1lvRXI3Um5q?=
 =?utf-8?B?UnpXY21QWWFiZElXNGxaNTBiWWpsazQ4MFR5SHpFVkwrUEk3MmJ2d0gxd0xn?=
 =?utf-8?B?MmZXNTN0Uk9YMWJlcDZoaEZwRC93RGtlYTNmYml3bGJ3a2F1L3VDQ3dBcmkw?=
 =?utf-8?B?T0JnN3BLY3FBUnlaZ003bDhHM1dRRnFISG9veVcwSlBoR054S20zZlE2OXc1?=
 =?utf-8?B?RHJGekw0dVlkOFFzMGM0MFNiZnlYU2RORlJRVDc3aWZtM3lFL1Q0a2xzSURr?=
 =?utf-8?B?L1JCeGt3Z0ZWZWZvYS9MK0E4dVFRK2JoR21MdzA3d3VwUW9mOHVad2l4dkN4?=
 =?utf-8?B?ZzBEWXA0ckFSTEpvSnc4UlVWdjJ5RDU3dU53YkpTNmJoL2ROMHkvSWxHQ0lp?=
 =?utf-8?B?VnJFMDh4RWFyQnFXYXE1UWs2YVlCK2JFZEVoeU0xb2xtSS9TYWd1YThTV1pa?=
 =?utf-8?B?WmRTbXRkTXgvc3d4MFVUODRyZGhvZlZUUkF0TG5oR1hnZ24rckMzY0JRb29M?=
 =?utf-8?Q?P/UEvEDEIHO5nmM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea1061a-c8a3-4b45-c289-08dbd6f87aa9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 14:24:50.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QOwVh7+JUbdIodxmJet7/3vVgjnHsa/QYX2LabK1uG/Qpq358UuhpjUXn0YBJEj0t2I7ThDqnF1rv2xihOmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270125
X-Proofpoint-ORIG-GUID: _HITjBcozwt0IjY96_dfi1TBtm6OtSlo
X-Proofpoint-GUID: _HITjBcozwt0IjY96_dfi1TBtm6OtSlo

On 26/10/2023 23:06, Andrii Nakryiko wrote:
> On Wed, Oct 25, 2023 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>
>> On Wed, 2023-10-25 at 15:30 -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Wed, Oct 25, 2023 at 03:12:49PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> But I guess the acks/reviews + my tests are enough to merge this as-is,
>>>> thanks for your work on this!
>>>
>>> Ok, its in the 'next' branch so that it can go thru:
>>>
>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>
>>> But the previous days are all failures, probably something else is
>>> preventing this test from succeeding? Andrii?
>>
>> It looks like the latest run succeeded, while a number of previous
>> runs got locked up for some reason. All using the same kernel
>> checkpoint commit. I know how to setup local github runner,
>> so I can try to replicate this by forking the repo,
>> redirecting CI to my machine and executing it several times.
>> Will do this over the weekend, need to work on some verifier
>> bugs first.
>>
> 
> BPF selftests are extremely unreliable under slow Github runners,
> unfortunately. Kernel either crashes or locks up very frequently. It
> has nothing to do with libbpf and we don't seem to see this in BPF CI
> due to having much faster runners there.
> 
> I'm not sure what to do about this apart from trying to identify a
> selftest that causes lock up (extremely time consuming endeavor) or
> just wait till libbpf CI will be privileged enough to gain its own
> fast AWS-based worker :)
> 
> But it seems like the last scheduled run succeeded, I think you are good.
>

Perhaps related, I've starting seeing regular RCU stalls with bpf-next
based kernels when running selftests that seem to have the
kprobe_multi_link_prog_run tests as a common factor. The system goes out
to lunch for a while and sometimes returns depending on which CPUs are hit.

In the same run I've also just run into a test hang after the
send_signal_sched_switch test completes; judging by the stack
traces and the alphabetical order it looks like setget_sockopt.c
is the culprit there. Seems to be a socket locking issue.

dmesg output follows for both issues..

[ 4151.256451] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 4151.273835] rcu: 	2-....: (4 ticks this GP)
idle=2d34/1/0x4000000000000000 softirq=194674/194674 fqs=3185
[ 4151.293115] rcu: 	(detected by 0, t=60043 jiffies, g=201485, q=5607
ncpus=8)
[ 4151.309961] Sending NMI from CPU 0 to CPUs 2:
[ 4151.322250] NMI backtrace for cpu 2
[ 4151.322295] CPU: 2 PID: 1101 Comm: systemd-journal Kdump: loaded
Tainted: G           O       6.6.0-rc7+ #159
[ 4151.322327] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.5.1 06/16/2021
[ 4151.322362] RIP: 0010:fprobe_handler+0x2d/0x2b0
[ 4151.322430] Code: fa 55 48 89 e5 41 57 49 89 cf 41 56 41 55 49 89 f5
41 54 49 89 fc 53 48 89 d3 48 83 ec 08 48 85 d2 74 0d f6 82 c8 00 00 00
01 <0f> 85 4f 01 00 00 65 4c 8b 34 25 80 27 03 00 49 8b b6 d0 13 00 00
[ 4151.322463] RSP: 0018:ffffc900001208a0 EFLAGS: 00000046
[ 4151.322525] RAX: ffff88811336b380 RBX: ffff88810614ca40 RCX:
ffffc900001208e0
[ 4151.322558] RDX: ffff88810614ca40 RSI: ffffffffb4666b5d RDI:
ffffffffb4584884
[ 4151.322585] RBP: ffffc900001208d0 R08: 0000000000000000 R09:
0000000000000000
[ 4151.322619] R10: 0000000000000000 R11: 0000000000000000 R12:
ffffffffb4584884
[ 4151.322658] R13: ffffffffb4666b5d R14: ffffffffffffffef R15:
ffffc900001208e0
[ 4151.322694] FS:  00007f7ec44b4a40(0000) GS:ffff888237c80000(0000)
knlGS:0000000000000000
[ 4151.322725] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4151.322757] CR2: 00007f7ebb9462d0 CR3: 0000000101b10003 CR4:
0000000000770ee0
[ 4151.322789] PKRU: 55555554
[ 4151.322818] Call Trace:
[ 4151.322856]  <NMI>
[ 4151.322926]  ? show_regs+0x69/0x80
[ 4151.323045]  ? nmi_cpu_backtrace+0xa0/0x110
[ 4151.323271]  ? nmi_cpu_backtrace_handler+0x15/0x20
[ 4151.323356]  ? nmi_handle+0x64/0x160
[ 4151.323526]  ? fprobe_handler+0x2d/0x2b0
[ 4151.323687]  ? default_do_nmi+0x6e/0x180
[ 4151.323855]  ? exc_nmi+0x151/0x1d0
[ 4151.324015]  ? end_repeat_nmi+0x16/0x67
[ 4151.324114]  ? kprobe_multi_link_prog_run.isra.0+0x9d/0x130
[ 4151.324172]  ? __rcu_read_unlock+0x4/0x40
[ 4151.324459]  ? kprobe_multi_link_prog_run.isra.0+0x9d/0x130
[ 4151.324509]  ? __rcu_read_unlock+0x4/0x40
[ 4151.324585]  ? fprobe_handler+0x2d/0x2b0
[ 4151.324755]  ? fprobe_handler+0x2d/0x2b0
[ 4151.324958]  ? fprobe_handler+0x2d/0x2b0
[ 4151.325102]  </NMI>
[ 4151.325130]  <IRQ>
[ 4151.325749]  ? __rcu_read_unlock+0x9/0x40
[ 4151.325918]  ? __rcu_read_unlock+0x9/0x40
[ 4151.325996]  ? kprobe_multi_link_prog_run.isra.0+0x9d/0x130
[ 4151.326097]  ? __rcu_read_unlock+0x9/0x40
[ 4151.326146]  ? kprobe_multi_link_prog_run.isra.0+0x9d/0x130
[ 4151.326224]  ? __pfx_copy_from_kernel_nofault_allowed+0x10/0x10
[ 4151.326360]  ? copy_from_kernel_nofault+0x26/0xf0
[ 4151.326460]  ? kprobe_multi_link_handler+0x28/0x40
[ 4151.326542]  ? copy_from_kernel_nofault_allowed+0x4/0x50
[ 4151.326615]  ? fprobe_handler+0x12f/0x2b0
[ 4151.326696]  ? __pfx_irq_enter_rcu+0x10/0x10
[ 4151.327030]  ? __pfx_irq_enter_rcu+0x10/0x10
[ 4151.327282]  ? __pfx_irq_enter_rcu+0x10/0x10
[ 4151.327357]  ? copy_from_kernel_nofault_allowed+0x9/0x50
[ 4151.327545]  ? copy_from_kernel_nofault_allowed+0x9/0x50
[ 4151.327631]  ? copy_from_kernel_nofault+0x26/0xf0
[ 4151.327737]  ? copy_from_kernel_nofault_allowed+0x9/0x50
[ 4151.327786]  ? copy_from_kernel_nofault+0x26/0xf0
[ 4151.327833]  ? irq_enter_rcu+0x4/0x80
[ 4151.327884]  ? __pfx_irq_enter_rcu+0x10/0x10
[ 4151.327934]  ? sysvec_irq_work+0x4f/0xe0
[ 4151.328011]  ? get_entry_ip+0x32/0x80
[ 4151.328191]  ? kprobe_multi_link_handler+0x19/0x40
[ 4151.328271]  ? irq_enter_rcu+0x4/0x80
[ 4151.328349]  ? fprobe_handler+0x12f/0x2b0
[ 4151.328904]  ? early_xen_iret_patch+0xc/0xc
[ 4151.329053]  ? irq_enter_rcu+0x9/0x80
[ 4151.329230]  ? irq_enter_rcu+0x9/0x80
[ 4151.329308]  ? sysvec_irq_work+0x4f/0xe0
[ 4151.329415]  ? irq_enter_rcu+0x9/0x80
[ 4151.329465]  ? sysvec_irq_work+0x4f/0xe0
[ 4151.329599]  ? asm_sysvec_irq_work+0x1f/0x30
[ 4151.330062]  ? rcu_read_unlock_special+0xd5/0x190
[ 4151.330211]  ? rcu_read_unlock_special+0xcf/0x190
[ 4151.330419]  ? __rcu_read_unlock+0x33/0x40
[ 4151.330495]  ? uncharge_batch+0xe8/0x140
[ 4151.330618]  ? __mem_cgroup_uncharge+0x70/0x90
[ 4151.330860]  ? __folio_put+0x36/0x80
[ 4151.330964]  ? free_page_and_swap_cache+0x87/0x90
[ 4151.331064]  ? tlb_remove_table_rcu+0x2c/0x50
[ 4151.331189]  ? rcu_do_batch+0x1bf/0x550
[ 4151.331264]  ? rcu_do_batch+0x159/0x550
[ 4151.331614]  ? rcu_core+0x183/0x370
[ 4151.331794]  ? rcu_core_si+0x12/0x20
[ 4151.331870]  ? __do_softirq+0x10e/0x327
[ 4151.332187]  ? __irq_exit_rcu+0xa8/0x110
[ 4151.332295]  ? irq_exit_rcu+0x12/0x20
[ 4151.332374]  ? sysvec_apic_timer_interrupt+0xb0/0xe0
[ 4151.332450]  </IRQ>
[ 4151.332479]  <TASK>
[ 4151.332595]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[ 4151.333055]  ? _raw_spin_unlock_irqrestore+0x21/0x50
[ 4151.333227]  ? __wake_up_common_lock+0x8a/0xc0
[ 4151.333644]  ? __wake_up+0x17/0x20
[ 4151.333717]  ? fsnotify_insert_event+0x121/0x1a0
[ 4151.334004]  ? inotify_handle_inode_event+0x158/0x240
[ 4151.334336]  ? fsnotify_handle_inode_event.isra.0+0x6f/0xe0
[ 4151.334410]  ? send_to_group+0x2ad/0x320
[ 4151.334771]  ? fsnotify+0x25c/0x5a0
[ 4151.335385]  ? __fsnotify_parent+0x21b/0x330
[ 4151.335698]  ? __fsnotify_parent+0x9/0x330
[ 4151.335963]  ? notify_change+0x42f/0x4c0
[ 4151.336018]  ? __fsnotify_parent+0x9/0x330
[ 4151.336070]  ? notify_change+0x42f/0x4c0
[ 4151.336173]  ? notify_change+0x9/0x4c0
[ 4151.336474]  ? do_truncate+0x87/0xe0
[ 4151.336528]  ? do_truncate+0x87/0xe0
[ 4151.336960]  ? do_sys_ftruncate+0x1af/0x210
[ 4151.337209]  ? __x64_sys_ftruncate+0x1e/0x30
[ 4151.337285]  ? do_syscall_64+0x3e/0x90
[ 4151.337382]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4151.337984]  </TASK>
[ 4151.338018] INFO: NMI handler (nmi_cpu_backtrace_handler) took too
long to run: 15.770 msecs
[ 4154.063929] rcu: INFO: rcu_preempt detected expedited stalls on
CPUs/tasks: { } 72585 jiffies s: 2429 root: 0x0/.
[ 4200.980354] 8021q: 802.1Q VLAN Support v1.8
[ 4200.982157] 8021q: adding VLAN 0 to HW filter on device ens3
[ 4254.123516] test_progs[47486] is installing a program with
bpf_probe_write_user helper that may corrupt user memory!
[ 4254.123530] test_progs[47486] is installing a program with
bpf_probe_write_user helper that may corrupt user memory!


This second issue causes a hang in selftest execution as
described above after send_signal_sched_switch

[ 4263.776211] ------------[ cut here ]------------
[ 4263.781022] Voluntary context switch within RCU read-side critical
section!
[ 4263.781036] WARNING: CPU: 2 PID: 47486 at
kernel/rcu/tree_plugin.h:320 rcu_note_context_switch+0x2dd/0x320
[ 4263.783303] Modules linked in: sch_fq 8021q garp mrp dummy tun ipip
tunnel4 ip_tunnel bpf_preload bpf_testmod(O) veth cls_bpf sch_ingress
ipt_REJECT xt_comment xt_owner nft_compat nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat ip_set cuse vfat fat
intel_rapl_msr intel_rapl_common bochs kvm_amd drm_vram_helper ccp
drm_ttm_helper ttm kvm drm_kms_helper irqbypass drm joydev pcspkr
i2c_piix4 sch_fq_codel xfs iscsi_tcp libiscsi_tcp libiscsi nvme_tcp
nvme_fabrics nvme nvme_core sd_mod t10_pi crc64_rocksoft_generic
crc64_rocksoft sg virtio_net net_failover failover virtio_scsi
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3
ata_generic pata_acpi ata_piix aesni_intel crypto_simd cryptd virtio_pci
virtio_pci_legacy_dev serio_raw virtio_pci_modern_dev libata floppy
qemu_fw_cfg dm_multipath sunrpc dm_mirror dm_region_hash dm_log dm_mod
scsi_transport_iscsi ipmi_devintf ipmi_msghandler fuse [last unloaded:
bpf_testmod(O)]
[ 4263.795254] CPU: 2 PID: 47486 Comm: new_name Kdump: loaded Tainted: G
          O       6.6.0-rc7+ #159
[ 4263.796602] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.5.1 06/16/2021
[ 4263.797804] RIP: 0010:rcu_note_context_switch+0x2dd/0x320
[ 4263.798772] Code: 08 f0 83 44 24 fc 00 48 89 de 4c 89 f7 e8 5b 98 ff
ff e9 f0 fd ff ff 48 c7 c7 d0 00 d3 b5 c6 05 96 1b 3b 02 01 e8 c3 19 f4
ff <0f> 0b e9 83 fd ff ff a9 ff ff ff 7f 0f 84 3f fe ff ff 65 48 8b 3c
[ 4263.801495] RSP: 0018:ffffc9000f4f7b68 EFLAGS: 00010082
[ 4263.802493] RAX: 0000000000000000 RBX: ffff888237cb3e00 RCX:
0000000000000000
[ 4263.803676] RDX: 0000000000000003 RSI: ffffffffb5cdb4f1 RDI:
00000000ffffffff
[ 4263.804842] RBP: ffffc9000f4f7b88 R08: 0000000000000000 R09:
ffffc9000f4f79d0
[ 4263.805989] R10: 0000000000000003 R11: ffffffffb67f4908 R12:
0000000000000000
[ 4263.807158] R13: ffff8881003acd40 R14: 0000000000000001 R15:
00000000000000e1
[ 4263.808334] FS:  00007fd0577417c0(0000) GS:ffff888237c80000(0000)
knlGS:0000000000000000
[ 4263.809625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4263.810690] CR2: 0000000006954568 CR3: 000000010ecb2004 CR4:
0000000000770ee0
[ 4263.811903] PKRU: 55555554
[ 4263.812656] Call Trace:
[ 4263.813401]  <TASK>
[ 4263.814095]  ? show_regs+0x69/0x80
[ 4263.814897]  ? __warn+0x8d/0x150
[ 4263.815713]  ? rcu_note_context_switch+0x2dd/0x320
[ 4263.816686]  ? report_bug+0x196/0x1c0
[ 4263.817549]  ? srso_alias_return_thunk+0x5/0x7f
[ 4263.818503]  ? irq_work_queue+0x13/0x60
[ 4263.819387]  ? handle_bug+0x45/0x80
[ 4263.820219]  ? exc_invalid_op+0x1c/0x70
[ 4263.821089]  ? asm_exc_invalid_op+0x1f/0x30
[ 4263.821994]  ? rcu_note_context_switch+0x2dd/0x320
[ 4263.822961]  ? rcu_note_context_switch+0x2dd/0x320
[ 4263.823916]  __schedule+0x60/0x770
[ 4263.824765]  ? __raw_spin_lock_irqsave+0x23/0x60
[ 4263.825720]  ? srso_alias_return_thunk+0x5/0x7f
[ 4263.826662]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 4263.827617]  schedule+0x6a/0xf0
[ 4263.828383]  __lock_sock+0x7d/0xc0
[ 4263.829178]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 4263.830145]  lock_sock_nested+0x54/0x60
[ 4263.830982]  do_ip_setsockopt+0x10b4/0x11a0
[ 4263.831859]  ? srso_alias_return_thunk+0x5/0x7f
[ 4263.832766]  ? srso_alias_return_thunk+0x5/0x7f
[ 4263.833655]  sol_ip_sockopt+0x3c/0x80
[ 4263.834444]  __bpf_setsockopt+0x5f/0xa0
[ 4263.835222]  bpf_sock_ops_setsockopt+0x19/0x30
[ 4263.836064]  bpf_prog_e2095e3611d57c9f_bpf_test_sockopt_int+0xbc/0x127
[ 4263.837110]  bpf_prog_493685a3bae00bbd_bpf_test_ip_sockopt+0x49/0x4f
[ 4263.838124]  bpf_prog_e80acd4ed535c5e2_skops_sockopt+0x433/0xe95
[ 4263.839102]  ? migrate_disable+0x7b/0x90
[ 4263.839865]  __cgroup_bpf_run_filter_sock_ops+0x91/0x140
[ 4263.840769]  __inet_listen_sk+0x106/0x130
[ 4263.841529]  ? lock_sock_nested+0x43/0x60
[ 4263.842259]  inet_listen+0x4d/0x70
[ 4263.842935]  __sys_listen+0x75/0xc0
[ 4263.843624]  __x64_sys_listen+0x18/0x20
[ 4263.844309]  do_syscall_64+0x3e/0x90
[ 4263.844969]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4263.845788] RIP: 0033:0x7fd156f9c82b
[ 4263.846461] Code: f0 ff ff 73 01 c3 48 8b 0d 52 46 38 00 f7 d8 64 89
01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 32 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 46 38 00 f7 d8 64 89 01 48
[ 4263.848837] RSP: 002b:00007ffda4b93ed8 EFLAGS: 00000246 ORIG_RAX:
0000000000000032
[ 4263.849892] RAX: ffffffffffffffda RBX: 00000000068d85b0 RCX:
00007fd156f9c82b
[ 4263.850912] RDX: 0000000000000010 RSI: 0000000000000001 RDI:
000000000000002c
[ 4263.851932] RBP: 00007ffda4b93f20 R08: 0000000000000010 R09:
0000000000000000
[ 4263.852953] R10: 00007ffda4b93eb0 R11: 0000000000000246 R12:
0000000000411fa0
[ 4263.853975] R13: 00007ffda4b94370 R14: 0000000000000000 R15:
0000000000000000
[ 4263.855011]  </TASK>
[ 4263.855564] ---[ end trace 0000000000000000 ]---
[ 4323.847899] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[ 4323.849648] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-7):
P47486/1:b..l
[ 4323.850749] rcu: 	(detected by 4, t=60004 jiffies, g=212293, q=44343
ncpus=8)
[ 4323.851852] task:new_name        state:D stack:0     pid:47486
ppid:47485  flags:0x00000000
[ 4323.853085] Call Trace:
[ 4323.853711]  <TASK>
[ 4323.854296]  __schedule+0x265/0x770
[ 4323.855023]  ? __raw_spin_lock_irqsave+0x23/0x60
[ 4323.855861]  schedule+0x6a/0xf0
[ 4323.856547]  __lock_sock+0x7d/0xc0
[ 4323.857271]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 4323.858168]  lock_sock_nested+0x54/0x60
[ 4323.858923]  do_ip_setsockopt+0x10b4/0x11a0
[ 4323.859710]  ? srso_alias_return_thunk+0x5/0x7f
[ 4323.860545]  ? srso_alias_return_thunk+0x5/0x7f
[ 4323.861373]  sol_ip_sockopt+0x3c/0x80
[ 4323.862093]  __bpf_setsockopt+0x5f/0xa0
[ 4323.862837]  bpf_sock_ops_setsockopt+0x19/0x30
[ 4323.863643]  bpf_prog_e2095e3611d57c9f_bpf_test_sockopt_int+0xbc/0x127
[ 4323.864668]  bpf_prog_493685a3bae00bbd_bpf_test_ip_sockopt+0x49/0x4f
[ 4323.865678]  bpf_prog_e80acd4ed535c5e2_skops_sockopt+0x433/0xe95
[ 4323.866664]  ? migrate_disable+0x7b/0x90
[ 4323.867441]  __cgroup_bpf_run_filter_sock_ops+0x91/0x140
[ 4323.868356]  __inet_listen_sk+0x106/0x130
[ 4323.869117]  ? lock_sock_nested+0x43/0x60
[ 4323.869885]  inet_listen+0x4d/0x70
[ 4323.870595]  __sys_listen+0x75/0xc0
[ 4323.871300]  __x64_sys_listen+0x18/0x20
[ 4323.872042]  do_syscall_64+0x3e/0x90
[ 4323.872761]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4323.873637] RIP: 0033:0x7fd156f9c82b
[ 4323.874387] RSP: 002b:00007ffda4b93ed8 EFLAGS: 00000246 ORIG_RAX:
0000000000000032
[ 4323.875496] RAX: ffffffffffffffda RBX: 00000000068d85b0 RCX:
00007fd156f9c82b
[ 4323.876583] RDX: 0000000000000010 RSI: 0000000000000001 RDI:
000000000000002c
[ 4323.877679] RBP: 00007ffda4b93f20 R08: 0000000000000010 R09:
0000000000000000
[ 4323.878774] R10: 00007ffda4b93eb0 R11: 0000000000000246 R12:
0000000000411fa0
[ 4323.879866] R13: 00007ffda4b94370 R14: 0000000000000000 R15:
0000000000000000
[ 4323.880952]  </TASK>
[ 4334.246892] rcu: INFO: rcu_preempt detected expedited stalls on
CPUs/tasks: { P47486 } 61561 jiffies s: 3197 root: 0x0/T
[ 4334.248460] rcu: blocking rcu_node structures (internal RCU debug):
[ 4424.359789] INFO: task new_name:47486 blocked for more than 122 seconds.
[ 4424.361458]       Tainted: G        W  O       6.6.0-rc7+ #159
[ 4424.362418] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 4424.363570] task:new_name        state:D stack:0     pid:47486
ppid:47485  flags:0x00000000
[ 4424.364799] Call Trace:
[ 4424.365430]  <TASK>
[ 4424.368934]  __schedule+0x265/0x770
[ 4424.369663]  ? __raw_spin_lock_irqsave+0x23/0x60
[ 4424.370499]  schedule+0x6a/0xf0
[ 4424.371189]  __lock_sock+0x7d/0xc0
[ 4424.371906]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 4424.372794]  lock_sock_nested+0x54/0x60
[ 4424.373532]  do_ip_setsockopt+0x10b4/0x11a0
[ 4424.374302]  ? srso_alias_return_thunk+0x5/0x7f
[ 4424.375127]  ? srso_alias_return_thunk+0x5/0x7f
[ 4424.375947]  sol_ip_sockopt+0x3c/0x80
[ 4424.376653]  __bpf_setsockopt+0x5f/0xa0
[ 4424.377381]  bpf_sock_ops_setsockopt+0x19/0x30
[ 4424.378184]  bpf_prog_e2095e3611d57c9f_bpf_test_sockopt_int+0xbc/0x127
[ 4424.379190]  bpf_prog_493685a3bae00bbd_bpf_test_ip_sockopt+0x49/0x4f
[ 4424.380188]  bpf_prog_e80acd4ed535c5e2_skops_sockopt+0x433/0xe95
[ 4424.381150]  ? migrate_disable+0x7b/0x90
[ 4424.381885]  __cgroup_bpf_run_filter_sock_ops+0x91/0x140
[ 4424.382762]  __inet_listen_sk+0x106/0x130
[ 4424.383515]  ? lock_sock_nested+0x43/0x60
[ 4424.384290]  inet_listen+0x4d/0x70
[ 4424.384992]  __sys_listen+0x75/0xc0
[ 4424.385690]  __x64_sys_listen+0x18/0x20
[ 4424.386425]  do_syscall_64+0x3e/0x90
[ 4424.387150]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4424.387991] RIP: 0033:0x7fd156f9c82b
[ 4424.388702] RSP: 002b:00007ffda4b93ed8 EFLAGS: 00000246 ORIG_RAX:
0000000000000032
[ 4424.389804] RAX: ffffffffffffffda RBX: 00000000068d85b0 RCX:
00007fd156f9c82b
[ 4424.390862] RDX: 0000000000000010 RSI: 0000000000000001 RDI:
000000000000002c
[ 4424.391913] RBP: 00007ffda4b93f20 R08: 0000000000000010 R09:
0000000000000000
[ 4424.392987] R10: 00007ffda4b93eb0 R11: 0000000000000246 R12:
0000000000411fa0
[ 4424.394047] R13: 00007ffda4b94370 R14: 0000000000000000 R15:
0000000000000000
[ 4424.395117]  </TASK>
[ 4424.395701] INFO: task dtprobed:49514 blocked for more than 122 seconds.
[ 4424.396751]       Tainted: G        W  O       6.6.0-rc7+ #159
[ 4424.397696] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 4424.398858] task:dtprobed        state:D stack:0     pid:49514 ppid:1
     flags:0x00000002
[ 4424.400036] Call Trace:
[ 4424.400651]  <TASK>
[ 4424.401258]  __schedule+0x265/0x770
[ 4424.401975]  ? srso_alias_return_thunk+0x5/0x7f
[ 4424.402795]  schedule+0x6a/0xf0
[ 4424.403472]  synchronize_rcu_expedited+0x185/0x200
[ 4424.404313]  ? __pfx_wait_rcu_exp_gp+0x10/0x10
[ 4424.405101]  ? __pfx_autoremove_wake_function+0x10/0x10
[ 4424.405966]  ? srso_alias_return_thunk+0x5/0x7f
[ 4424.406758]  ? preempt_count_add+0x52/0xc0
[ 4424.407499]  namespace_unlock+0xd6/0x1b0
[ 4424.408234]  put_mnt_ns+0x74/0xa0
[ 4424.408903]  free_nsproxy+0x1f/0x1b0
[ 4424.409609]  exit_task_namespaces+0x6f/0x90
[ 4424.410388]  do_exit+0x28b/0x520
[ 4424.411041]  ? srso_alias_return_thunk+0x5/0x7f
[ 4424.411837]  ? srso_alias_return_thunk+0x5/0x7f
[ 4424.412635]  do_group_exit+0x39/0x90
[ 4424.413351]  __x64_sys_exit_group+0x1c/0x20
[ 4424.414106]  do_syscall_64+0x3e/0x90
[ 4424.414810]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 4424.415650] RIP: 0033:0x7ff70a952cf6
[ 4424.416373] RSP: 002b:00007ffeecec40b8 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[ 4424.417494] RAX: ffffffffffffffda RBX: 00007ff70ac14820 RCX:
00007ff70a952cf6
[ 4424.418560] RDX: 0000000000000002 RSI: 000000000000003c RDI:
0000000000000002
[ 4424.419636] RBP: 0000000000000002 R08: 00000000000000e7 R09:
ffffffffffffff68
[ 4424.420689] R10: 00007ffeecec3fbf R11: 0000000000000246 R12:
00007ff70ac14820
[ 4424.421768] R13: 0000000000000001 R14: 00007ff70ac1a310 R15:
0000000000000000
[ 4424.422837]  </TASK>


>> Thanks,
>> Eduard.

