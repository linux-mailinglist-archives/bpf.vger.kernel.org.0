Return-Path: <bpf+bounces-17698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED0C811BFD
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58DF2828E9
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBCE59551;
	Wed, 13 Dec 2023 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4OFu2oO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lLSuYwBZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23981A7
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 10:10:07 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDER6I9023612;
	Wed, 13 Dec 2023 18:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=in2PILD9AlkNthNQuMUHuLVmrAZ10tYYXXYqFOSXp3c=;
 b=m4OFu2oOJ0ld+NahXPp6/ra+Z7S/oUvBPQ3nRKjiVIoblUcjJOTJtKBZK3gvea5gb4Q3
 KP+PM80bjrexaP4hY5PFSqdZ44/bxc4w1vxoQGboEZc7gQWCJtC57zEkYHjpeu+WnqID
 PcrrldzyBFRBZfFnLdc6RyzmWznrAJvebDR78UxP6jHLKlULIbJyHY0sWR8haDS/tgHx
 IcQ60JF+0p83FXneSO3ebf0+2+5EKDqEQQosmZhW82sKQhrEjv3l58Yg3DXteoDdPzbV
 4zKX4GQYWkemWCJIMrsGIuvjBQR6M8XJTtBDF+sorqdQGJGMBnaKZnWZk/khdcSMzuQl cQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu28ty5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 18:09:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDGmQsX008269;
	Wed, 13 Dec 2023 18:09:27 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8p3h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 18:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc6ZHDX0o6l1wVH2CvfpfNb+KIzJIPViVIwoJqWyCiWOlzxw9OC8Q4V1yAmDQBO6n4zITq3uQ5CBLUJVPAQ94eHQ9/2tXG/CW1jt/38AGK6PsqWJVRPhuzzWKZMyQUKmttqfMs0bxiKqh8Mj8CNRHlpPv08vwzcOnZO5n3TtdxWHnTvilbI1CZGA/eH0Sv82+78xcdWd7QUF06uZ4XsRwn+ZavPZpXuI5xBlGsufvzZXwNuSIuPa+CLeHh0x6eR9baAAkX7+MbOCKrlUn6fumq+4v0M7hjxbE1Dl0nRkIzE4Z/DguoM1dwVZXlw8330zzzdUEpc+SfQ6YXk3v1CeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in2PILD9AlkNthNQuMUHuLVmrAZ10tYYXXYqFOSXp3c=;
 b=AwvbJsudgitn0C7Y2jtzP1RMCxk/avGCq8/xIzezQK+KHhgblzT4obUQDlWZBFb+hJxSFW55feH/LzimXFOWOVVoMoF8X0usitubro0io3EEVZkjmEfJGgmkTkPtBY7XH2Lyx/LNgFDzrQjYTA+zzkStOaEw/bNxhXxPLXmOczFL9Xiz9Jqk6i3WyqI7c3xoHKElSSgZ0jOnr8K0B2fiMEysp0W3QKrO6RQjH9pOd0I/eC/IVVIrNMnYHzaaLw129yAHIjdxVnKGj6mRG9aOmIO/tyWBDXhHtGfO4oSxAQzIHv8uOedvjq5SAypN3BYrfF2jr7Qw4JLeDP01M2BVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in2PILD9AlkNthNQuMUHuLVmrAZ10tYYXXYqFOSXp3c=;
 b=lLSuYwBZfh5EQ6CxqW8CEXmo00KpLSllSFHB4YXyvqlZK8GiqfDJ7uAzb1lr7aD+QD9bzDHX/kOHuQeRoGMKg58F7LfxiqXFoOa72H6MVPIdfz59VEJsvUWCZU/tuVeBDzStXE9zlk1eiMYhP9DNK9bfWamAjmZm7/nlaxvbYCM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 18:09:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 18:09:24 +0000
Message-ID: <838a8857-505b-1dc1-cc7e-c8c0960e666a@oracle.com>
Date: Wed, 13 Dec 2023 18:08:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC bpf-next 2/2] selftests/bpf: Add uprobe multi fail test
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>
References: <20231213141234.1210389-1-jolsa@kernel.org>
 <20231213141234.1210389-2-jolsa@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231213141234.1210389-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7225bbee-6947-43b3-de1f-08dbfc06a322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iM4GLk2xfjCTwk/AnMfrKWiNu9A63GBvqZVUV4rJjmX60YnMIq/NP9pQl5YeY8mNWB91bR72zQb2+f6YXPn5znBAI0bf3yR7yex40Qm61oCpPCIFYUrbOjeeLC8mIz6BdacrGrzWqNozZI3lzQyySqTKe+TYU1TQ/Cz3mab/ZW6oniBd81xaXVwbrsxcD6/WpCnfNK38IqyuCDuiyr6XV5EiPY+pbAZwAMENOMtPhtbT2TATX2H4DR3L/wBPbCT+c+xXK93L6ZQz+jxChORx4MNauZhisH8Pd6O9PKo13GWKLFM4/cjuu2dDOgaLI7YQx9wtPeCE8YyRV7hB1XKTxwBRvIzW345v+8XGbJdRyiJdjZip0zXCH/KQWG3gUUWtPYmPjxsVntBoQTfR38snvslITu3dm7FUc0xg+qp2KOq5pUv1ueOufAEo4KYp5BlhlBbS07eclfGuOZ4jNze1ltg5AfIVEpjBzVEHTpUbyNhtqWg4PXxZiZCB/dMHOMxbIko0d/ExYPLaPtFqEaNlCs6a50VZJh5f02SPFuxGEoIhidLcxKuRBjOXPSJHZAx+jGjnZjLI69dcdb/csGCXx2v8JR7x6skKTW/+m/EVgAbBjbJLpG1rX9MMIkRprbknMJuknKTGE69zhYy2CiRQxA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31696002)(83380400001)(6506007)(53546011)(6512007)(8676002)(2616005)(5660300002)(44832011)(41300700001)(4326008)(8936002)(7416002)(2906002)(478600001)(6486002)(38100700002)(6666004)(110136005)(316002)(66556008)(66476007)(54906003)(86362001)(66946007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y244bWlqcWZOQnhqampLdXJrL3AvYUMwa3BxSytpTjFVdWhlMHN6SmxxbkN6?=
 =?utf-8?B?NXBzOUhvMFpZV0VFSGtEblJFMlMyWHZtbGVuUEFZOHVLREdRbTNHRHdXZ3gw?=
 =?utf-8?B?MDROTStESmNiL3Z0ellZSi9Bc2dtRU53K3d2dDU3dDlFTFpvNFlEejVaVVU0?=
 =?utf-8?B?YzF3TzYzdEtGb1ZrWTN5TnhhZlRHa1ZxUlJUVTNzMWVPZmhRbnArck91aFNu?=
 =?utf-8?B?cGJQZkRldmJUWXllTjE4UGFmaUpLemtUM09lbWZXdkM4YVJJNU82dlZuQ3hV?=
 =?utf-8?B?UXREaU1HODNLZU9EOWNBS2duYU1zWWgwdlhUaGVLc1JGN0JySXE3NUpNSFhm?=
 =?utf-8?B?cGdVcmY3Ykovc3hFaENmZHRtb1ZMS08zTFVCaXRYSG1ycU5oVkltWFhMTkZa?=
 =?utf-8?B?VXdyOVo4bDk2dFUrWnJ2ZWhxalROT2pHWEsxWHdHSUZtdW5mcDJxZzNBL0cr?=
 =?utf-8?B?dnJ6VDFPQldTOFNWY21BM2JpRG1JQ25FNy9xVlhYQlNGeWk0S0NGYnZlcDl1?=
 =?utf-8?B?dXlLa2JFYmR0bHh2ZTc3WTJmbTdra1JtTUhXR0JEVERlZmthdVhGQlVVWUdS?=
 =?utf-8?B?SXo3YkRxbU9LbE9FTnpNY09JQm9nb3V4VHUxcmRZOEJMNkpRRy8xQ0NyN0Ew?=
 =?utf-8?B?NStBVHl3a2xpb0hhVVBtZDRid1h0MEVEeWpOQ1FsWHRBVnVlQUJxTTJYbktC?=
 =?utf-8?B?Q1R6ZEZ5eml1ajI0SGNkOHNONzlnendOM2xWWG1kUTlpejM5VWdwY01kS0JS?=
 =?utf-8?B?dXlWM3F6QW9LVDRoSVZNMVdLVStkTnhoZG1KbjlMSlJXTmV1M3pQVWp2cVNw?=
 =?utf-8?B?T1VFS3BoaUgzU0UvemZKZEllcXRjRFVySlZPNkxQTEo3cWUydlpxOCtrejVw?=
 =?utf-8?B?ZCtKbjlmOXM2ZU0xMDFlcFROblV3SFJCQzlRQUIzdUlrenY0blZsVHNMVTFK?=
 =?utf-8?B?Y3doMXdoQmVFcm5adTRiNGdSbE5wYlNmSmhjQ0xQN08zWTlDRG5oLzVsNEI2?=
 =?utf-8?B?R0w3bkl2bDV2N040V2R6TjN6c3JQTGV0NzJ5UFFQem96YjRIUlFEMDJjbDZ2?=
 =?utf-8?B?SVZiTlRiamtHU3FrckozanlySzhBNkk5SnY0Z2NYdytmU3hDdHlzVmJqODVs?=
 =?utf-8?B?N0JhaTI2WkJzWU9pUWVTNXN4UUZhcDJzcEptRTkwdFRZZUtIS2FkN21sVDRi?=
 =?utf-8?B?VVVSbGJhSjZwbFVwcTdmV0hVMTFMWTdzeCtZWnlrTlBhN1dzNXh2VjBIOUZv?=
 =?utf-8?B?M2NNcnJCU0MvbTBQN09EWjBEdFR5SXFoWlhnZVJtdS9BNDcyS0JtTDc4a05D?=
 =?utf-8?B?WlZmbFlMRWhnRDYxUlNtL3FweWRpekx1bjEzaXQ1ZDFwR0VkbjV2WGdsNjJm?=
 =?utf-8?B?NEhwMXhmcGpWREVvQXFxd1ZFOEo1aVF3SGt1V2NPWEhPbHNxazk1RVRmYmVG?=
 =?utf-8?B?L3VIMXNKZGRtb2NmYTg5ZnE5aXk0MmVnZEhjMUtraVFKVHQ4bkw2eEZ6R0N3?=
 =?utf-8?B?N3N4bngwOHlrNEt6STVJbFVBWHRqM09laXF0SExJWmtVeUtMK1FKbC9jc3pD?=
 =?utf-8?B?L3JsbnJaNGxkMER3WUJZdmF1dk1kRGJ2RUFCdXMxTzRkOGhhVHhBS1JxR0Jr?=
 =?utf-8?B?WnVHT1ZxcnJxVWxMTnY1MEM1TUxURlc3czd2OW00MkR4Rk9JNk9EUks1NGU5?=
 =?utf-8?B?NmxxalRIMG5WQTlHdHdGcW45ZGkvN1RwK0Z6Z3pHRDFXMktxdjlmWDdIRzhI?=
 =?utf-8?B?NTZGSmtpaHMzZ2RJVmZMVlJiaFR6Z1N0V1Jidk05MzBuQXppSFIrUnZJRmt5?=
 =?utf-8?B?VmttOFVVT2JKTzJFMEF4dlU0cXdHSTVaUlBNbDlBcWk1SHlSNkI1VjNwUmdp?=
 =?utf-8?B?Y3lXY2pVYkJQcG01UmZMWUtWUkhqSGV0V013VUEwK1ZMUFFOeXFPZTJNWi94?=
 =?utf-8?B?UHNPeVNRdzg5V3BHdHg3ZmwveXk5WU1LZjBuQTFqVElZMnphbjkvaFhhWnVa?=
 =?utf-8?B?c3ozWTZ1UjRNRVNYRklrNGNlaDNIZ0MrditMZE5xNVJKWVR6MFdGcUw3Q1JF?=
 =?utf-8?B?OHBnV2thM3VLVTFjMTdmR3hPS1lJWDQ3VWhwUGFocmVnMkN1bTZxM2x6bHN6?=
 =?utf-8?B?U0taWUdLYlFWYSs1TVV0RzhhaG1hZkg1ZC92cG53TldTdXdCZXZkRlRXTzF0?=
 =?utf-8?Q?rBNDGoflESlrco6njoWVFzA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aG5rNzJjZ3ppbUJNR1I2WVdwNG8vRHpoTHR3NmIybmRydE5yMGlaQkd1SU9n?=
 =?utf-8?B?L1NFYWVVZ3lEdmdTb1pOcEpoYmphK3QzWUlPb2VlRi9nT3R0NFNsd091R2pW?=
 =?utf-8?B?aWV5cE5Qa1dCNG1hbUs5TGtHcmE4ek1kUkc1OXIzYTRaUTlMU01kRDFHWEhu?=
 =?utf-8?B?UGI1N1UzeFJSS1hMZk1hQkUzUzhYK2ZaeWVBcTIwUGE5eEIxdTI2UFlJUE0z?=
 =?utf-8?B?QTY0NndUZC90UGtLQVZaaGZCaHhBendpQUlQNklRRCtvOTg2OGQrMXQwYUk1?=
 =?utf-8?B?ODlmNmJjM3doZVkvSkZvUUYvZ29RMWVuMHM3RkhDZy95cW5ZTzBZWnJqdWFx?=
 =?utf-8?B?RkhpbENsT0pYQjN4ZkxoejFxOStJa2ttWWpvOWpIQ0dhaFpZYW9xTWR6dDNI?=
 =?utf-8?B?Wmc4Ui9YSGsxbldVVnJSQ0J4azhBYkdNUENySWdObVdwUG9Sc2JCWjh5cnp5?=
 =?utf-8?B?SWNiQnNuT3NPbm1pSW1qSXhoek9oSkxHSmEvM2wraFRxeGVWVG5ibW5HSDlp?=
 =?utf-8?B?OXNRWFB0dStscDQxc3l4aFZscW9RTUZVY1FLNXR2cHNDRlhrV0NYbXk1akZl?=
 =?utf-8?B?SjJYZ2tjSjRnMXV5MGpQSFBSVm5TUkUxeFZKT0lGekl4TEZaazlPR2hodXpH?=
 =?utf-8?B?VnE3VGVPamZFZmkrVzJhVkJTbm0zREFZWklKTFl4Z2djSk9NbSsvSnF3Rm1O?=
 =?utf-8?B?Qk5ObVFvK2FQR2s5SmJhN0lzdEdaMm9YOGllMzBONVFuM2xsRTlKdFNkaXVX?=
 =?utf-8?B?R2VsYStWc3ltMFVnbzlGRkxheTdDaGhQMTdES1NLWHVRZm9aVzNKRWlOZkpQ?=
 =?utf-8?B?WURVTUdGWWtJRm1xMVJrMWhUcVlOb01IZnEvek5WdllGTG5lSURqWGFXRnVS?=
 =?utf-8?B?YU1JaVRXc3k0Vy9KRHZVYU55TkpKdzd3NFN5bkV4ZVBjeUE3b25PaUZSZUND?=
 =?utf-8?B?WXFKME5LYjh3MG53QnFISEc0R3dzdjZQVkxPbWR2RXBiaGRYN0w2NEpFb2ZU?=
 =?utf-8?B?VmVmSGJqVDJzUWRzR1NGS0RZMGVoWGFDT0U3U3dGeDJxQ3FnWDU4MU9ZWXNv?=
 =?utf-8?B?TGE3clJKdFRGeVpTdnBrWnVJNjUxNGpWekE0SkowSDhCZFhiais1VytZYlhV?=
 =?utf-8?B?Qjk1eVBuTWFiaThKQ2FKKzVsM090eE1INzZtRzQrRFBtZUkwaElNRTB0ek1v?=
 =?utf-8?B?dTJTYzRHTStxcW5KNmtmanJwa2ptNGpKdVljL2x5bXg4NkRBbHk5bnoxRTFD?=
 =?utf-8?B?eTRXbnhkQU9yYUNRSDI4VTlPTExwRzB0MkV6UFpkWUdwOUVrdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7225bbee-6947-43b3-de1f-08dbfc06a322
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 18:09:24.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTC8yWLjwX0S4IDf4bqqCF7EwlaauL9mbDUtPTk6YV3DptIX9YLw3QTdFLvlHkbBH3iGM2bFk6L7uYzwXeqZYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130130
X-Proofpoint-ORIG-GUID: BJ8T2cqrmekL8WrewBNzmYoYTM-xHgJz
X-Proofpoint-GUID: BJ8T2cqrmekL8WrewBNzmYoYTM-xHgJz

On 13/12/2023 14:12, Jiri Olsa wrote:
> We fail to create uprobe if we pass negative offset,
> adding test for that.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

small suggestion below..

> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index ece260cf2c0b..aebfa7e6bfd6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -326,6 +326,31 @@ void test_link_api(void)
>  	__test_link_api(child);
>  }
>  
> +static void test_attach_api_fails(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +	const char *path = "/proc/self/exe";
> +	struct uprobe_multi *skel = NULL;
> +	int prog_fd, link_fd;
> +	long offset = -1;
> +
> +	skel = uprobe_multi__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
> +		return;
> +
> +	/* fail_1 - attach on negative offset */
> +	opts.uprobe_multi.path = path;
> +	opts.uprobe_multi.offsets = (unsigned long *) &offset;
> +	opts.uprobe_multi.cnt = 1;
> +
> +	prog_fd = bpf_program__fd(skel->progs.uprobe_extra);
> +	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
> +	if (!ASSERT_EQ(link_fd, -EINVAL, "link_fd"))
> +		close(link_fd);
> +

would it be worth exercising a few additional error cases here? not
specifying offsets/cnt triggers an EINVAL too.

